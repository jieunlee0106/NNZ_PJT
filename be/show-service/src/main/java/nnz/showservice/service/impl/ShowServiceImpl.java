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
import nnz.showservice.dto.res.ResShowDTO;
import nnz.showservice.entity.*;
import nnz.showservice.exception.ErrorCode;
import nnz.showservice.repository.*;
import nnz.showservice.service.KafkaProducer;
import nnz.showservice.service.ShowService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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

    @Override
    public ShowDTO readShowInfo(Long showId) {
        // 공연 정보 조회 시 해당 공연의 공연 태그 목록까지 가져온다.
        Show show = showRepository.findById(showId)
                .orElseThrow(() -> new CustomException(ErrorCode.SHOW_NOT_FOUND));
        return ShowDTO.entityToDTO(show);
    }

    @Override
    public PageDTO readShowsByCategory(String categoryName, PageRequest pageRequest) {
        Category category = categoryRepository.findByName(categoryName)
                .orElseThrow(() -> new CustomException(ErrorCode.CATEGORY_NOT_FOUND));
        Page<Show> showPage = showRepository.findByCategoryAndIsDeleteFalse(category, pageRequest);

        if (category.getParentCode() != null && (category.getParentCode().equals("SPO") || category.getParentCode().equals("ESP"))) {

            List<SportsDTO> sportsDTOs = new ArrayList<>();

            // 구단 이미지 넣기 위한 로직
            showPage.forEach(show -> {
                String[] team = show.getTitle().split("vs");
                String leftTeam = team[0].trim();
                String rightTeam = team[1].trim();

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
        Category category = categoryRepository.findByName(categoryName)
                .orElseThrow(() -> new CustomException(ErrorCode.CATEGORY_NOT_FOUND));

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
        Tag tag = tagRepository.findByTag(showTagName)
                .orElseThrow(() -> new CustomException(ErrorCode.TAG_NOT_FOUND));
        // 태그로 검색하는 경우는 공연, 나눔 API 둘다 호출하기 때문에
        // 공연 정보가 없더라도 해당 태그의 카운트만 하나 증가시켜 주면 된다.
        tag.updatePlusViews();
        KafkaMessage<TagDTO> message = KafkaMessage.update().body(TagDTO.of(tag));
        try {
            producer.sendMessage(message);
        } catch (JsonProcessingException e) {
            throw new CustomException(ErrorCode.JSON_PROCESSING_EXCEPTION);
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
        Category category = categoryRepository.findByName(categoryName)
                .orElseThrow(() -> new CustomException(ErrorCode.CATEGORY_NOT_FOUND));
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
}
