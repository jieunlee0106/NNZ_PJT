package com.example.nnzcrawling.service;

import com.example.nnzcrawling.dto.TagDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "DEV-TAG-SERVICE")
public interface TagFeignClient {

    @PostMapping("/tag-service/tags")
    List<TagDTO> createTag(@RequestBody List<TagDTO> tags);
}