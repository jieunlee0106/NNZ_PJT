package com.example.nnzcrawling.service.impl;

import com.example.nnzcrawling.entity.Category;
import com.example.nnzcrawling.entity.ShowCrawling;
import com.example.nnzcrawling.entity.TagCrawling;
import com.example.nnzcrawling.repository.CategoryRepository;
import com.example.nnzcrawling.repository.ShowCrawlingRepository;
import com.example.nnzcrawling.selenium.CrawlingESports;
import com.example.nnzcrawling.selenium.CrawlingShows;
import com.example.nnzcrawling.selenium.CrawlingSports;
import com.example.nnzcrawling.service.ShowCrawlingService;
import com.example.nnzcrawling.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ShowCrawlingServiceImpl implements ShowCrawlingService {

    private final CrawlingShows crawlingShows;
    private final CrawlingESports crawlingESports;
    private final CrawlingSports crawlingSports;
    private final ShowCrawlingRepository showCrawlingRepository;
    private final CategoryRepository categoryRepository;
    private final TagService tagService;

    @Override
    @Scheduled(cron = "0 00 22 1/1 * *")
    public void createShow() {

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
            showCrawlingEntities.addAll(eSports);
            showCrawlingEntities.addAll(sports);
            tagCrawlingEntities.addAll(showTags);
            tagCrawlingEntities.addAll(eSportsTags);
            tagCrawlingEntities.addAll(sportsTags);

            for (ShowCrawling showCrawling : showCrawlingEntities) {
                // orElseThrow()에서 에러 명시해주기
                Category category = categoryRepository.findByName(showCrawling.getCategory()).orElseThrow();
                // 데이터가 있을 경우 카테고리 코드로 변환
                showCrawling.setCategory(category.getCode());
            }

            // 공연 크롤링 정보 저장
            showCrawlingRepository.createShows(showCrawlingEntities);

            for (TagCrawling tag : tagCrawlingEntities) {
                System.out.println(tag);
            }

            // 태그 생성 메소드 호출
            tagService.createTag(tagCrawlingEntities);

        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
