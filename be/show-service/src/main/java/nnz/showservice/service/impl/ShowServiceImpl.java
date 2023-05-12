package nnz.showservice.service.impl;

import io.github.eello.nnz.common.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import nnz.showservice.dto.ShowDTO;
import nnz.showservice.dto.ShowTagDTO;
import nnz.showservice.dto.SportsDTO;
import nnz.showservice.dto.res.ResBannerDTO;
import nnz.showservice.dto.res.ResShowDTO;
import nnz.showservice.entity.*;
import nnz.showservice.repository.*;
import nnz.showservice.service.ShowService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
                        .leftTeamImage(leftTeamImage.getImage())
                        .rightTeamImage(rightTeamImage.getImage())
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
    public PageDTO readShowsByShowTag(String showTagName, PageRequest pageRequest) {

        // todo : error handling
        Tag tag = tagRepository.findByTag(showTagName).orElseThrow();
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
        for (Show show: shows) {
            popularMap.put(show, show.getNanums().size());
        }

        List<Show> keySet = new ArrayList<>(popularMap.keySet());
        keySet.sort(((o1, o2) -> popularMap.get(o2).compareTo(popularMap.get(o1))));

        List<ResShowDTO> resShowDTOs = new ArrayList<>();
        keySet.subList(0, 9).forEach(show -> {
            resShowDTOs.add(ResShowDTO.of(show));
        });

        return resShowDTOs;
    }

    @Override
    public List<ResBannerDTO> readBanner() {
        List<Banner> banners = bannerRepository.findTop3ByOrderByUpdatedAtDesc();
        List<ResBannerDTO> resBannerDTOs = banners.stream().map(ResBannerDTO::of).collect(Collectors.toList());
        return resBannerDTOs;
    }
}
