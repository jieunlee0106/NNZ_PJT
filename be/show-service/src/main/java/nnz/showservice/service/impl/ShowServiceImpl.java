package nnz.showservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.dto.PageDTO;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import nnz.showservice.dto.ShowDTO;
import nnz.showservice.dto.ShowTagDTO;
import nnz.showservice.dto.SportsDTO;
import nnz.showservice.dto.TagDTO;
import nnz.showservice.dto.res.ResBannerDTO;
import nnz.showservice.dto.res.ResSearchDTO;
import nnz.showservice.dto.res.ResShowDTO;
import nnz.showservice.dto.res.ResTagDTO;
import nnz.showservice.entity.*;
import nnz.showservice.repository.*;
import nnz.showservice.service.KafkaProducer;
import nnz.showservice.service.NanumFeignClient;
import nnz.showservice.service.ShowService;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ShowServiceImpl implements ShowService {

    private final ShowRepository showRepository;
    private final CategoryRepository categoryRepository;
    private final TeamImageRepository teamImageRepository;
    private final TagRepository tagRepository;
    private final ShowTagRepository showTagRepository;
    private final BannerRepository bannerRepository;
    private final KafkaProducer producer;
    private final NanumFeignClient nanumFeignClient;

    @Override
    public ShowDTO readShowInfo(Long showId) {

        // todo : Error Handling
        // 공연 정보 조회 시 해당 공연의 공연 태그 목록까지 가져온다.
        Show show = showRepository.findById(showId).orElseThrow();
        return ShowDTO.entityToDTO(show);
    }

    @Override
    public PageDTO readShowsByCategory(String categoryName, PageRequest pageRequest) {

        // todo : Error Handling
        Category category = categoryRepository.findByName(categoryName).orElseThrow();
        Page<Show> showPage = showRepository.findByCategoryAndIsDeleteFalse(category, pageRequest);

        if (category.getParentCode() != null && (category.getParentCode().equals("SPO") || category.getParentCode().equals("ESP"))) {

            List<SportsDTO> sportsDTOs = new ArrayList<>();

            // 구단 이미지 넣기 위한 로직
            showPage.forEach(show -> {
                String[] team = show.getTitle().split("vs");
                String leftTeam = team[0].trim();
                String rightTeam = team[1].trim();

                // todo: 스포츠의 경우 이미지 있지만 E스포츠의 경우 이미지가 없다
                TeamImage leftTeamImage = teamImageRepository.findById(leftTeam).orElse(null);
                TeamImage rightTeamImage = teamImageRepository.findById(rightTeam).orElse(null);

                List<ShowTagDTO> showTags = show.getShowTags()
                        .stream()
                        .map(ShowTagDTO::entityToDTO)
                        .collect(Collectors.toList());

                SportsDTO sportsDTO = SportsDTO.builder()
                        .id(show.getId())
                        .ageLimit(show.getAgeLimit())
                        .location(show.getLocation())
                        .leftTeam(leftTeam)
                        .rightTeam(rightTeam)
                        .leftTeamImage(leftTeamImage != null ? leftTeamImage.getImage() : null)
                        .rightTeamImage(rightTeamImage != null ? rightTeamImage.getImage() : null)
                        .date(show.getStartDate())
                        .showTags(showTags)
                        .build();

                sportsDTOs.add(sportsDTO);
            });

            int start = (int) pageRequest.getOffset();
            int end = Math.min((start + pageRequest.getPageSize()), sportsDTOs.size());
            Page<SportsDTO> sportsDTOPage = new PageImpl<>(sportsDTOs.subList(start, end), pageRequest, sportsDTOs.size());
            ;
            return PageDTO.of(sportsDTOPage);
        }

        Page<ShowDTO> showDTOPage = showPage.map(ShowDTO::entityToDTO);
        return PageDTO.of(showDTOPage);
    }

    @Override
    public PageDTO searchShowsByCategoryAndTitle(String categoryName, String title, PageRequest pageRequest) {

        // todo : Error Handling
        Category category = categoryRepository.findByName(categoryName).orElseThrow();

        Page<Show> showPage = null;
        if (title != null) {
            showPage = showRepository.findByCategoryAndTitleContainingAndIsDeleteFalse(category, title, pageRequest);
        } //
        else {
            showPage = showRepository.findByCategoryAndIsDeleteFalse(category, pageRequest);
        }

        Page<ShowDTO> showDTOPage = showPage.map(ShowDTO::entityToDTO);
        return PageDTO.of(showDTOPage);
    }

    @Override
    @Transactional
    public PageDTO readShowsByShowTag(String showTagName, PageRequest pageRequest) {

        // todo : error handling
        Tag tag = tagRepository.findByTag(showTagName).orElseThrow();
        // 태그로 검색하는 경우는 공연, 나눔 API 둘다 호출하기 때문에
        // 공연 정보가 없더라도 해당 태그의 카운트만 하나 증가시켜 주면 된다.
        tag.updatePlusViews();
        KafkaMessage<TagDTO> message = KafkaMessage.update().body(TagDTO.of(tag));
        try {
            producer.sendMessage(message);
        } catch (JsonProcessingException e) {
            // todo: error handling
        }

        List<ShowTag> showTags = showTagRepository.findAllByTag(tag);

        List<Show> shows = new ArrayList<>();
        showTags.forEach(showTag -> {
            shows.add(showTag.getShow());
        });

        int start = (int) pageRequest.getOffset();
        int end = Math.min((start + pageRequest.getPageSize()), shows.size());
        Page<Show> showPage = new PageImpl<>(shows.subList(start, end), pageRequest, shows.size());

        Page<ResShowDTO> resShowDTOPage = showPage.map(ResShowDTO::of);
        return PageDTO.of(resShowDTOPage);
    }

    @Override
    public List<ResShowDTO> readPopularShowsByCategory(String categoryName) {

        // todo : error handling
        Category category = categoryRepository.findByName(categoryName).orElseThrow();
        List<Show> shows = showRepository.findAllByCategory(category);

        Map<Show, Integer> popularMap = new HashMap<>();
        for (Show show : shows) {
            popularMap.put(show, show.getNanums().size());
        }

        List<Show> keySet = new ArrayList<>(popularMap.keySet());
        keySet.sort(((o1, o2) -> popularMap.get(o2).compareTo(popularMap.get(o1))));

        List<ResShowDTO> resShowDTOs = new ArrayList<>();
        if (keySet.size() > 8) {
            keySet.subList(0, 9).forEach(show -> {
                resShowDTOs.add(ResShowDTO.of(show));
            });
        } //
        else {
            keySet.forEach(show -> {
                resShowDTOs.add(ResShowDTO.of(show));
            });
        }

        return resShowDTOs;
    }

    @Override
    public List<ResBannerDTO> readBanner() {
        List<Banner> banners = bannerRepository.findTop3ByOrderByUpdatedAtDesc();
        List<ResBannerDTO> resBannerDTOs = banners.stream().map(ResBannerDTO::of).collect(Collectors.toList());
        return resBannerDTOs;
    }

    @Override
    public List<TagDTO> readShowTagByShow(Long showId, Integer count) {
//        Show show = showRepository.findById(showId)
//                .orElseThrow(() -> new EntityNotFoundException("showId에 해당하는 공연이 존재하지 않습니다."));

        PageRequest pageRequest = PageRequest.of(0, count, Sort.by("views").descending());
//        List<Tag> showTags = showTagRepository.findTagByShow(show, pageRequest);
        List<Tag> showTags = tagRepository.findTagByShow(showId, pageRequest);
        return showTags.stream().map(TagDTO::of).collect(Collectors.toList());
    }

    @Override
    public ResSearchDTO searchShowByQuery(String query, Pageable pageable) {
        // 최대 태그 개수
        int maxTagCount = 10;

        // 검색어로 공연 검색 -> 시작일 오름차순
        PageRequest pageRequest =
                PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("startDate"));
        Page<Show> shows = showRepository.findByQuery(query, pageRequest);

        // 검색된 공연들의 ids
        List<Long> showIds = shows.getContent().stream().map(Show::getId).collect(Collectors.toList());

        // 검색된 공연들의 태그 -> 조회순으로
        List<Tag> showTags = tagRepository.findTagByShowIds(
                showIds,
                PageRequest.of(0, maxTagCount, Sort.by("views").descending())
        );

        // 관련 태그에 공연 태그 3개 추가
        List<ResTagDTO> relatedTags = showTags.subList(0, 3).stream().map(ResTagDTO::of).collect(Collectors.toList());

        // 공연 태그 개수에 따른 나눔 태그 조회 개수
        int nanumTagCount = maxTagCount - Math.min(3, showTags.size());

        // 검색된 공연으로 조회한 나눔 태그를 관련 태그에 추가
        if (showIds.size() > 0) { // 조회된 공연이 존재하면 나눔 태그를 조회해 관련 태그에 추가
            relatedTags.addAll(nanumFeignClient.getRelatedNanumTagByShow(showIds, nanumTagCount));
        }

        // 관련 태그의 남은 자리에 관련 공연 태그를 추가
        if (relatedTags.size() < 10 && showTags.size() >= 3) { // 관련 태그의 수가 10개가 안되고 조회된 공연의 태그가 3개 이상이면
            relatedTags.addAll(
                    showTags.subList(3, Math.min(maxTagCount, showTags.size())).stream()
                            .map(ResTagDTO::of)
                            .collect(Collectors.toList())
            );
        }

        return ResSearchDTO.of(shows, relatedTags);
    }
}
