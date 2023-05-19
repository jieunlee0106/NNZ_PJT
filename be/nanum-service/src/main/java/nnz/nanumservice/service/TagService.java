package nnz.nanumservice.service;

import nnz.nanumservice.dto.res.tag.ResTagDTO;

import java.util.List;

public interface TagService {

    List<ResTagDTO> readPopularRelatedNanumTagByShow(List<Long> showIds, Integer count);
}
