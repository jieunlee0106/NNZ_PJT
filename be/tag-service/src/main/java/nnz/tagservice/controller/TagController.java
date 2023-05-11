package nnz.tagservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import nnz.tagservice.dto.TagDTO;
import nnz.tagservice.service.TagService;
import nnz.tagservice.vo.TagVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/tag-service/tags")
@RequiredArgsConstructor
public class TagController {

    private final TagService tagService;

    @PostMapping
    public ResponseEntity<List<TagDTO>> createTag(@RequestBody List<TagVO> tags) {
        try {
            List<TagDTO> createdTags = tagService.createTag(tags);
            return new ResponseEntity<>(createdTags, HttpStatus.CREATED);
        } catch (JsonProcessingException e) {
            // todo : error handling
            System.out.println("asdfasdfasdfasdf");
            throw new RuntimeException();
        }
    }
}
