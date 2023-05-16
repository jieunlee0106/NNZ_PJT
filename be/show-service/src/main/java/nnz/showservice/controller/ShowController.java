package nnz.showservice.controller;

import io.github.eello.nnz.common.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import nnz.showservice.dto.BannerDTO;
import nnz.showservice.dto.CategoryDTO;
import nnz.showservice.dto.ShowDTO;
import nnz.showservice.dto.TagDTO;
import nnz.showservice.dto.res.ResBannerDTO;
import nnz.showservice.dto.res.ResSearchDTO;
import nnz.showservice.dto.res.ResShowDTO;
import nnz.showservice.service.CategoryService;
import nnz.showservice.service.ShowService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/show-service/shows")
@RequiredArgsConstructor
public class ShowController {

    private final ShowService showService;
    private final CategoryService categoryService;

    @GetMapping("/{showId}")
    public ResponseEntity<ShowDTO> readShowInfo(@PathVariable(name = "showId") Long showId) {
        return ResponseEntity.ok().body(showService.readShowInfo(showId));
    }

    @GetMapping
    public ResponseEntity<PageDTO> readShowsByCategory(
            @RequestParam(name = "category") String categoryName,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return ResponseEntity.ok().body(showService.readShowsByCategory(categoryName, pageRequest));
    }

    @GetMapping("/search")
    public ResponseEntity<PageDTO> searchShowsByCategoryAndTitle(
            @RequestParam(name = "category") String categoryName,
            @RequestParam(name = "title", required = false) String title,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return ResponseEntity.ok().body(showService.searchShowsByCategoryAndTitle(categoryName, title, pageRequest));
    }

    @GetMapping("/categories")
    public ResponseEntity<List<CategoryDTO>> readCategories(@RequestParam(name = "parent", required = false) String parent) {
        return ResponseEntity.ok().body(categoryService.readCategories(parent));
    }

    @GetMapping("/tag")
    public ResponseEntity<PageDTO> readShowsByShowTag(
            @RequestParam(name = "tag") String showTagName,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return new ResponseEntity<>(showService.readShowsByShowTag(showTagName, pageRequest), HttpStatus.OK);
    }

    @GetMapping("/popular")
    public ResponseEntity<List<ResShowDTO>> readPopularShowsByCategory(@RequestParam(name = "category") String categoryName) {
        return new ResponseEntity<>(showService.readPopularShowsByCategory(categoryName), HttpStatus.OK);
    }

    @GetMapping("/poster")
    public ResponseEntity<List<ResBannerDTO>> readBanners() {
        return new ResponseEntity<>(showService.readBanner(), HttpStatus.OK);
    }

    /**
     * 공연에 등록된 태그
     */
    @GetMapping("/{showId}/tags")
    public ResponseEntity<List<TagDTO>> readShowTagByShow(@PathVariable Long showId, @RequestParam("count") Integer count) {
        return ResponseEntity.ok(showService.readShowTagByShow(showId, count));
    }

    @GetMapping("/search/query")
    public ResponseEntity<ResSearchDTO> searchShowByQuery(@RequestParam("q") String query, Pageable pageable) {
        return new ResponseEntity<>(showService.searchShowByQuery(query, pageable), HttpStatus.OK);
    }
}
