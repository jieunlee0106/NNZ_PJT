package com.example.nnzcrawling.service.impl;

import com.example.nnzcrawling.dto.ShowSyncDTO;
import com.example.nnzcrawling.dto.TagDTO;
import com.example.nnzcrawling.entity.*;
import com.example.nnzcrawling.repository.*;
import com.example.nnzcrawling.selenium.CrawlingESports;
import com.example.nnzcrawling.selenium.CrawlingShows;
import com.example.nnzcrawling.selenium.CrawlingSports;
import com.example.nnzcrawling.service.KafkaProducer;
import com.example.nnzcrawling.service.ShowCrawlingService;
import com.example.nnzcrawling.service.TagFeignClient;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class ShowCrawlingServiceImpl implements ShowCrawlingService {

    private final CrawlingShows crawlingShows;
    private final CrawlingESports crawlingESports;
    private final CrawlingSports crawlingSports;
    private final ShowCrawlingRepository showCrawlingRepository;
    private final TagFeignClient tagFeignClient;
    private final KafkaProducer producer;
    private final CategoryRepository categoryRepository;
    private final ShowRepository showRepository;
    private final TeamImageRepository teamImageRepository;
    private final ShowTagRepository showTagRepository;
    private final TagRepository tagRepository;
    private final EntityManager em;

    @Override
    @Scheduled(cron = "10 49 15 1/1 * *")
    @Transactional
    public void createShow() {
        LocalDateTime startTime = LocalDateTime.now();
        List<ShowCrawling> showCrawlingEntities = new ArrayList<>();
        List<TagCrawling> tagCrawlingEntities = new ArrayList<>();

        try {
            List<ShowCrawling> shows = crawlingShows.getCrawlingData();
            List<ShowCrawling> eSports = crawlingESports.getCrawlingData();
            List<ShowCrawling> sports = crawlingSports.getCrawlingData();
            List<TagCrawling> showTags = crawlingShows.getTags();
            List<TagCrawling> eSportsTags = crawlingESports.getTags();
            List<TagCrawling> sportsTags = crawlingSports.getTags();

            showCrawlingEntities.addAll(shows);
            tagCrawlingEntities.addAll(showTags);
            showCrawlingEntities.addAll(eSports);
            tagCrawlingEntities.addAll(eSportsTags);
            showCrawlingEntities.addAll(sports);
            tagCrawlingEntities.addAll(sportsTags);

            // 공연 크롤링 정보 저장
            List<Show> showEntities = new ArrayList<>();
            showCrawlingEntities.forEach(v -> {
                Category category = categoryRepository.findByName(v.getCategory()).orElseThrow();
                showEntities.add(Show.of(v, category));
                Optional<Show> findShow = showRepository.findByTitleAndStartDateAndIsDeleteFalse(v.getTitle(), v.getStartDate());

                if (findShow.isEmpty()) {
                    Show show = Show.of(v, category);
                    showRepository.save(show);
                }
            });

            List<TagDTO> tagDTOs = new ArrayList<>();
            tagCrawlingEntities.forEach(v -> {
                tagDTOs.add(new TagDTO(v.getTitle(), v.getTag(), "show"));
            });
            log.info("tagDTOs.size() =  {}", tagDTOs.size());

            // 태그 생성 메소드 호출 및 태그 저장
            List<TagDTO> createdTags = tagFeignClient.createTag(tagDTOs);

            List<ShowTag> newShowTags = new ArrayList<>();
            for (TagDTO tagDTO : createdTags) {
                List<Show> findShows = showRepository.findByTitleContaining(tagDTO.getTitle());

                for (Show show : findShows) {
                    List<ShowTag> showTag = showTagRepository.findByShowAndTagId(show, tagDTO.getId());

                    // 없으면 생성하고 있으면 그대로 둔다.
                    if (showTag.isEmpty()) {
                        Tag tag = tagRepository.findById(tagDTO.getId()).orElse(null);
                        ShowTag newShowTag = ShowTag.builder()
                                .show(show)
                                .tag(tag)
                                .build();
                        newShowTags.add(newShowTag);
                        show.addTag(newShowTag);
                        showTagRepository.save(newShowTag);

                    }
                }
            }

            em.flush();

            sendShowToKafka(startTime);
            createTeamImage(sports);
        } catch (InterruptedException | JsonProcessingException e) {
            e.printStackTrace();
        }
    }

    @Override
    @Transactional
    public void createTeamImage(List<ShowCrawling> sports) {

        Map<String, String> teamMap = new HashMap<>();

        sports.forEach(sport -> {
            String[] team = sport.getTitle().split("vs");
            String leftTeam = team[0].trim();
            String rightTeam = team[1].trim();

            String leftTeamImage = null;
            String rightTeamImage = null;
            if (sport.getPosterImage() != null) {
                String[] teamImages = sport.getPosterImage().split("vs");
                leftTeamImage = teamImages[0].trim();
                rightTeamImage = teamImages[1].trim();
            }

            teamMap.put(leftTeam, leftTeamImage);
            teamMap.put(rightTeam, rightTeamImage);
        });

        teamMap.forEach((name, image) -> {
            TeamImage teamImage = teamImageRepository.findById(name).orElse(new TeamImage(name, image));
            teamImageRepository.save(teamImage);
        });
    }

    private void sendShowToKafka(LocalDateTime startTime) throws JsonProcessingException {
        log.info("send crawling data to kafka");
        List<Show> shows = showRepository.findAllByCreatedAtAfter(startTime);
        for (Show show : shows) {
            KafkaMessage message = KafkaMessage.create().body(ShowSyncDTO.of(show));
            producer.sendMessage(message);
        }
        log.info("send complete.");
    }
}
