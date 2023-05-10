package com.example.nnzcrawling.service;

import com.example.nnzcrawling.dto.ShowDTO;
import com.example.nnzcrawling.dto.ShowTagDTO;
import com.example.nnzcrawling.dto.TagDTO;
import com.example.nnzcrawling.entity.Category;
import com.example.nnzcrawling.entity.Show;
import com.example.nnzcrawling.entity.ShowTag;
import com.example.nnzcrawling.entity.Tag;
import com.example.nnzcrawling.repository.CategoryRepository;
import com.example.nnzcrawling.repository.ShowRepository;
import com.example.nnzcrawling.repository.ShowTagRepository;
import com.example.nnzcrawling.repository.TagRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaConsumer {

    private final TagRepository tagRepository;
    private final ShowTagRepository showTagRepository;
    private final ShowRepository showRepository;
    private final CategoryRepository categoryRepository;

    @Transactional
    @KafkaListener(topics = "dev-tag", groupId = "crawling-service-1")
    public void getTagMessage(String message) throws JsonProcessingException {
        KafkaMessage<TagDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, TagDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            Tag tag = Tag.of(kafkaMessage.getBody());
            tagRepository.save(tag);
        }
    }

    @Transactional
    @KafkaListener(topics = "dev-showtag", groupId = "crawling-service-2")
//    @KafkaHandler // 카프카의 해당 토픽에서 메시지를 얻으면 실행되는 함수
    public void getShowTagMessage(String message) throws JsonProcessingException {
        KafkaMessage<ShowTagDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ShowTagDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            // todo: error handling
            Show show = showRepository.findById(kafkaMessage.getBody().getShowId()).orElseThrow();
            Tag tag = tagRepository.findById(kafkaMessage.getBody().getTagId()).orElseThrow();
            ShowTag showTag = ShowTag.of(kafkaMessage.getBody(), show, tag);
            showTagRepository.save(showTag);
        }
    }

    // todo: 관리자에서 등록하는 공연에 대한 토픽은 따로 분리해야 할듯.
//    @Transactional
//    @KafkaListener(topics = "dev-show", groupId = "crawling-service-3")
//    public void getShowMessage(String message) throws JsonProcessingException {
//        KafkaMessage<ShowDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ShowDTO.class);
//        log.info("consume message: {}", message);
//        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
//        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());
//
//        // todo: error handling
//        Category category = categoryRepository.findById(kafkaMessage.getBody().getCategoryCode()).orElseThrow();
//        Show show = Show.dtoToEntity(kafkaMessage.getBody(), category);
//
//        showRepository.save(show);
//    }
}