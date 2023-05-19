package nnz.showservice.service;

import io.github.eello.nnz.common.dto.PageDTO;
import nnz.showservice.dto.BannerDTO;
import nnz.showservice.dto.CategoryDTO;
import nnz.showservice.dto.ShowDTO;
import nnz.showservice.dto.TagDTO;
import nnz.showservice.dto.res.ResBannerDTO;
import nnz.showservice.dto.res.ResSearchDTO;
import nnz.showservice.dto.res.ResShowDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface ShowService {

    ShowDTO readShowInfo(Long showId);

    PageDTO readShowsByCategory(String category, PageRequest pageRequest);

    PageDTO searchShowsByCategoryAndTitle(String categoryName, String title, PageRequest pageRequest);

    PageDTO readShowsByShowTag(String showTagName, PageRequest pageRequest);

    List<ResShowDTO> readPopularShowsByCategory(String categoryName);

    List<ResBannerDTO> readBanner();
    List<TagDTO> readShowTagByShow(Long showId, Integer count);
    ResSearchDTO searchShowByQuery(String query, Pageable pageable);
}
