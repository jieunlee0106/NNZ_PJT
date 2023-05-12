package com.example.nnzcrawling.service.impl;

import com.example.nnzcrawling.dto.ShowDTO;
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
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.*;
import java.util.stream.Collectors;

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
    @Scheduled(cron = "00 19 15 1/1 * *")
    @Transactional
    public void createShow() {

        List<ShowCrawling> showCrawlingEntities = new ArrayList<>();
        List<TagCrawling> tagCrawlingEntities = new ArrayList<>();

        try {
//            List<ShowCrawling> shows = crawlingShows.getCrawlingData();
            List<ShowCrawling> eSports = crawlingESports.getCrawlingData();
//            List<ShowCrawling> sports = crawlingSports.getCrawlingData();
//            List<TagCrawling> showTags = crawlingShows.getTags();
            List<TagCrawling> eSportsTags = crawlingESports.getTags();
//            List<TagCrawling> sportsTags = crawlingSports.getTags();

//            showCrawlingEntities.addAll(shows);
//            tagCrawlingEntities.addAll(showTags);
            showCrawlingEntities.addAll(eSports);
            tagCrawlingEntities.addAll(eSportsTags);
//            showCrawlingEntities.addAll(sports);
//            tagCrawlingEntities.addAll(sportsTags);

            System.out.println("tagCrawlingEntities.size() = " + tagCrawlingEntities.size());

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
//            showCrawlingRepository.createShows(showCrawlingEntities);

            // kafka producer 등록
//            for (ShowCrawling showCrawling : showCrawlingEntities) {
//                // todo : error handling
//                Show show = showRepository.findByTitleAndStartDateAndIsDeleteFalse(
//                        showCrawling.getTitle(), showCrawling.getStartDate()
//                ).orElseThrow();
//
//                ShowDTO showDTO = ShowDTO.of(show);
//
//                KafkaMessage<ShowDTO> kafkaMessage = KafkaMessage.create().body(showDTO);
//                producer.sendMessage(kafkaMessage);
//            }

            List<TagDTO> tagDTOs = new ArrayList<>();
            tagCrawlingEntities.forEach(v -> {
                tagDTOs.add(new TagDTO(v.getTitle(), v.getTag(), "show"));
            });

            System.out.println("tagDTOs.size() = " + tagDTOs.size());

            // 태그 생성 메소드 호출 및 태그 저장
            List<TagDTO> createdTags = tagFeignClient.createTag(tagDTOs);
            System.out.println("createdTags.size() = " + createdTags.size());
            System.out.println("createdTags = " + createdTags);
            List<Tag> tagList = tagRepository.saveAll(createdTags.stream().map(Tag::of).collect(Collectors.toList()));


            List<ShowTag> newShowTags = new ArrayList<>();
            for (TagDTO tagDTO : createdTags) {
                List<Show> findShows = showRepository.findByTitleContaining(tagDTO.getTitle());

                for (Show show : findShows) {
                    Optional<ShowTag> showTag = showTagRepository.findByShowAndTagId(show, tagDTO.getId());
                    System.out.println("show = " + show.getTitle());

                    // 없으면 생성하고 있으면 그대로 둔다.
                    if (!showTag.isPresent()) {
                        Tag tag = tagRepository.findById(tagDTO.getId()).orElse(null);
                        ShowTag newShowTag = ShowTag.builder()
                                .show(show)
                                .tag(tag)
                                .build();
                        newShowTags.add(newShowTag);
                        show.addTag(newShowTag);
//                        showTagRepository.save(newShowTag);

                    }
                }
            }
//            System.out.println("newShowTags.size() = " + newShowTags.size());
            showTagRepository.saveAll(newShowTags);

//            createTeamImage(sports);
//
            em.flush();

            sendShowToKafka();
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

    private void sendShowToKafka() throws JsonProcessingException {
        System.out.println("ShowCrawlingServiceImpl.sendShowToKafka");
        List<Show> shows = showRepository.findAll();
        for (Show show : shows) {
            System.out.println("send to kafka");
            KafkaMessage message = KafkaMessage.create().body(ShowSyncDTO.of(show));
            System.out.println("send to kafka");
            producer.sendMessage(message);
        }
    }
}
