package nnz.tagservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessage.KafkaMessageType;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.tagservice.dto.TagDTO;
import nnz.tagservice.entity.Tag;
import nnz.tagservice.repository.TagRepository;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Transactional
@RequiredArgsConstructor
public class KafkaDevConsumer implements KafkaConsumer {

    private final TagRepository tagRepository;

    @KafkaListener(topics = "pd-tag", groupId = "tag-service")
    public void consumeTagMessage(String message) throws JsonProcessingException {
        KafkaMessage<TagDTO> data = KafkaMessageUtils.deserialize(message, TagDTO.class);
        KafkaMessageType type = data.getType();
        TagDTO body = data.getBody();

        if (type == KafkaMessageType.UPDATE) {
            Optional<Tag> optTag = tagRepository.findById(body.getId());

            if (optTag.isEmpty()) {
                log.warn("태그 id: {}에 해당하는 태그가 존재하지 않습니다.", body.getId());
                return;
            }

            Tag tag = optTag.get();
            if (tag.getViews() < body.getViews()) {
                log.info("태그 id: {}의 조회수 업데이트 before: {} -> after {}", tag.getId(), tag.getViews(), body.getViews());
                tag.updateViews(body.getViews());
            }
        }

        log.info("Tag Update Success!");
    }
}