package nnz.tagservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.tagservice.dto.TagDTO;
import nnz.tagservice.dto.res.ResTagDTO;
import nnz.tagservice.vo.TagVO;

import java.util.List;

public interface TagService {

    List<TagDTO> createTag(List<TagVO> tags) throws JsonProcessingException;

    List<ResTagDTO> readPopularTags();

    String readBySearchAllTag(String search);
}
