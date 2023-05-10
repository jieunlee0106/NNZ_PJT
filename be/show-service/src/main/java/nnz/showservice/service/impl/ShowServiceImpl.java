package nnz.showservice.service.impl;

import io.github.eello.nnz.common.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import nnz.showservice.dto.ShowDTO;
import nnz.showservice.dto.ShowTagDTO;
import nnz.showservice.dto.SportsDTO;
import nnz.showservice.entity.Category;
import nnz.showservice.entity.Show;
import nnz.showservice.entity.TeamImage;
import nnz.showservice.repository.CategoryRepository;
import nnz.showservice.repository.ShowRepository;
import nnz.showservice.repository.TeamImageRepository;
import nnz.showservice.service.ShowService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ShowServiceImpl implements ShowService {

    private final ShowRepository showRepository;
    private final CategoryRepository categoryRepository;
    private final TeamImageRepository teamImageRepository;

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
}
