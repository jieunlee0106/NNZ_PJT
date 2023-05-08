package com.example.nnzcrawling.service.impl;

import com.example.nnzcrawling.dto.ShowDTO;
import com.example.nnzcrawling.dto.TagDTO;
import com.example.nnzcrawling.entity.Category;
import com.example.nnzcrawling.entity.Show;
import com.example.nnzcrawling.entity.ShowCrawling;
import com.example.nnzcrawling.entity.TagCrawling;
import com.example.nnzcrawling.repository.CategoryRepository;
import com.example.nnzcrawling.repository.ShowCrawlingRepository;
import com.example.nnzcrawling.repository.ShowRepository;
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

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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

    @Override
    @Scheduled(cron = "0 57 15 1/1 * *")
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

            // 공연 크롤링 정보 저장
//            List<Show> showEntities = new ArrayList<>();
            showCrawlingEntities.forEach(v -> {
                Category category = categoryRepository.findByName(v.getCategory()).orElseThrow();
//                showEntities.add(Show.of(v, category));
                Optional<Show> findShow = showRepository.findByTitleAndStartDateAndIsDeleteFalse(v.getTitle(), v.getStartDate());

                if (!findShow.isPresent()) {
                    Show show = Show.of(v, category);
                    showRepository.save(show);
                }
            });
//            showRepository.saveAll(showEntities);
//            showCrawlingRepository.createShows(showCrawlingEntities);

            // kafka producer 등록
            for (ShowCrawling showCrawling : showCrawlingEntities) {
                // todo : error handling
                Show show = showRepository.findByTitleAndStartDateAndIsDeleteFalse(
                        showCrawling.getTitle(), showCrawling.getStartDate()
                ).orElseThrow();

                ShowDTO showDTO = ShowDTO.of(show);

                KafkaMessage<ShowDTO> kafkaMessage = KafkaMessage.create().body(showDTO);
                producer.sendMessage(kafkaMessage);
            }

            List<TagDTO> tagDTOs = new ArrayList<>();
            tagCrawlingEntities.forEach(v -> {
                tagDTOs.add(new TagDTO(v.getTitle(), v.getTag(), "show"));
            });
            // 태그 생성 메소드 호출
            tagFeignClient.createTag(tagDTOs);

        } catch (InterruptedException | JsonProcessingException e) {
            e.printStackTrace();
        }
    }
}
