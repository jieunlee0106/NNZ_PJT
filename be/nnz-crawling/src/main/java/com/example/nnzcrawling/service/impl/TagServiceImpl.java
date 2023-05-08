package com.example.nnzcrawling.service.impl;

import com.example.nnzcrawling.entity.Show;
import com.example.nnzcrawling.entity.ShowTag;
import com.example.nnzcrawling.entity.Tag;
import com.example.nnzcrawling.entity.TagCrawling;
import com.example.nnzcrawling.repository.ShowRepository;
import com.example.nnzcrawling.repository.ShowTagRepository;
import com.example.nnzcrawling.repository.TagRepository;
import com.example.nnzcrawling.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {

    private final TagRepository tagRepository;
    private final ShowRepository showRepository;
    private final ShowTagRepository showTagRepository;

    @Override
    public void createTag(List<TagCrawling> tags) {

        for (TagCrawling tagCrawl : tags) {

            // 태그 테이블의 tag 값과 받아온 리스트들의 tag 값으로 태그 테이블에 정보가 있는지 확인한다.
            Optional<Tag> tag = tagRepository.findByTag(tagCrawl.getTag());

            // 정보가 없다면 태그 테이블에 데이터를 생성하고 생성된 데이터를 받아온다.
            if (!tag.isPresent()) {
                Tag newTag = Tag.builder()
                        .tag(tagCrawl.getTag())
                        .views(0)
                        .build();

                tag = Optional.of(tagRepository.save(newTag));
            }
            // 리스트들의 title 값으로 show 테이블의 title 값을 비교하여 show 테이블의 id 값을 받아온다.
            // 위 주석과 같이 로직을 구성하기 위해선 크롤링한 공연정보가 먼저 db에 insert 되어야 한다.
            // 스포츠의 경우 팀별로 태그가 저장되어야 할거 같은데 title이 팀1vs팀2 이런식으로 있다면 공연 정보를 찾지 못한다.
            List<Show> shows = showRepository.findByTitleContaining(tagCrawl.getTitle());

            for (Show show : shows) {
                // 공연 데이터를 받아오면 공연 태그 테이블에 값이 있는지 show 값과 tag 값으로 검색해본다.
                Optional<ShowTag> showTag = showTagRepository.findByShowAndTag(show, tag.get());

                // 없으면 생성하고 있으면 그대로 둔다.
                if (!showTag.isPresent()) {
                    ShowTag newShowTag = ShowTag.builder()
                            .show(show)
                            .tag(tag.get())
                            .build();
                    showTagRepository.save(newShowTag);
                }
            }
        }
    }
}
