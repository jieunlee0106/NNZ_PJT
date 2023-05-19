package nnz.showservice.service;

import nnz.showservice.dto.res.ResTagDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "DEV-NANUM-SERVICE")
public interface NanumFeignClient {

    @GetMapping("/nanum-service/nanums/tag/related")
    List<ResTagDTO> getRelatedNanumTagByShow(
            @RequestParam("showIds") List<Long> showIds,
            @RequestParam("count") Integer count
    );
}
