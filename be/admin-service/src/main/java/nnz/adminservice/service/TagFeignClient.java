package nnz.adminservice.service;

import nnz.adminservice.vo.TagVO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "DEV-TAG-SERVICE")
public interface TagFeignClient {

    @PostMapping("/tag-service/tags")
    void createTag(@RequestBody List<TagVO> tags);
}
