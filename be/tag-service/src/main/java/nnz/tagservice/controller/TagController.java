package nnz.tagservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
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
    public ResponseEntity<Void> createTag(@RequestBody List<TagVO> tags) {
        try {
            tagService.createTag(tags);
        } catch (JsonProcessingException e) {
            // todo : error handling
            System.out.println("asdfasdfasdfasdf");
        }
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
}
