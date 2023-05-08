package nnz.tagservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.tagservice.vo.TagVO;

import java.util.List;

public interface TagService {

    void createTag(List<TagVO> tags) throws JsonProcessingException;
}
