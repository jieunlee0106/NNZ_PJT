package nnz.tagservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.tagservice.dto.TagDTO;
import nnz.tagservice.dto.res.ResTagDTO;
import nnz.tagservice.entity.*;
import nnz.tagservice.exception.ErrorCode;
import nnz.tagservice.repository.*;
import nnz.tagservice.service.KafkaProducer;
import nnz.tagservice.service.TagService;
import nnz.tagservice.vo.TagVO;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class TagServiceImpl implements TagService {

    private final TagRepository tagRepository;
    private final KafkaProducer producer;

    @Override
    public List<TagDTO> createTag(List<TagVO> tags) throws JsonProcessingException {
        List<TagDTO> createdTags = new ArrayList<>();
        for (TagVO tagVO : tags) {

            Optional<Tag> tag = tagRepository.findByTag(tagVO.getTag());
            TagDTO dto;
            if (!tag.isPresent()) { // 생성된 태그가 없으면
                Tag newTag = Tag.builder()
                        .tag(tagVO.getTag())
                        .views(0)
                        .build();

                newTag = tagRepository.save(newTag);
                dto = TagDTO.of(newTag);

                KafkaMessage<TagDTO> kafkaMessage = KafkaMessage.create().body(dto);
                producer.sendMessage(kafkaMessage, "tag");
            } else {
                dto = TagDTO.of(tag.get());
            }

            if (tagVO.getTitle() != null) {
                dto.setTitle(tagVO.getTitle());
            }
            createdTags.add(dto);
        }

        return createdTags;
    }

    @Override
    public List<ResTagDTO> readPopularTags() {
        List<Tag> tags = tagRepository.findTop12ByOrderByViewsDesc();
        List<ResTagDTO> resTagDTOs = tags.stream().map(ResTagDTO::of).collect(Collectors.toList());
        return resTagDTOs;
    }

    @Override
    @Cacheable(key = "#search", value = "ResTagDTO", cacheManager = "cacheManager")
    public String readBySearchAllTag(String search) {

        List<Tag> tags = tagRepository.findAllByTagContaining(search);
        List<ResTagDTO> resTagDTOs = new ArrayList<>();
        tags.forEach(tag -> {
            resTagDTOs.add(ResTagDTO.of(tag));
        });

        ObjectMapper mapper = new ObjectMapper();
        String jsonStr = null;
        try {
            jsonStr = mapper.writeValueAsString(resTagDTOs);
        } catch (JsonProcessingException e) {
            throw new CustomException(ErrorCode.JSON_PROCESSING_EXCEPTION);
        }

        return jsonStr;
    }
}
