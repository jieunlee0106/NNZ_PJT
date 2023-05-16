package nnz.nanumservice.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.entity.Tag;
import nnz.nanumservice.repository.TagRepository;
import nnz.nanumservice.service.TagService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {

    private final TagRepository tagRepository;

    @Override
    public List<ResTagDTO> readPopularRelatedNanumTagByShow(List<Long> showIds, Integer count) {
        PageRequest pageRequest = PageRequest.of(0, count, Sort.by("views").descending());
        List<Tag> relatedNanumTags = tagRepository.findByShowId(showIds, pageRequest);
        return relatedNanumTags.stream().map(ResTagDTO::of).collect(Collectors.toList());
    }
}
