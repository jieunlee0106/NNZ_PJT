package nnz.nanumservice.service;

import nnz.nanumservice.dto.TagDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "DEV-TAG-SERVICE")
public interface TagFeignClient {

    @PostMapping("/tag-service/tags")
    void createTag(@RequestBody List<TagDTO> tags);
}
