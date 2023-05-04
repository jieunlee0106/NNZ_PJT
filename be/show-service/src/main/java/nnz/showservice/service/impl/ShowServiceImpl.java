package nnz.showservice.service.impl;

import io.github.eello.nnz.common.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import nnz.showservice.dto.ShowDTO;
import nnz.showservice.dto.SportsDTO;
import nnz.showservice.entity.Category;
import nnz.showservice.entity.Show;
import nnz.showservice.repository.CategoryRepository;
import nnz.showservice.repository.ShowRepository;
import nnz.showservice.service.ShowService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ShowServiceImpl implements ShowService {

    private final ShowRepository showRepository;
    private final CategoryRepository categoryRepository;

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

        if (category.getParentCode().equals("SPO") || category.getParentCode().equals("ESP")) {
            Page<SportsDTO> sportsDTOPage = showPage.map(SportsDTO::entityToDto);
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
