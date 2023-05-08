package nnz.tagservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.tagservice.entity.Show;
import nnz.tagservice.repository.ShowRepository;
import org.springframework.kafka.annotation.KafkaHandler;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaConsumer {

    private final ShowRepository showRepository;

    @KafkaListener(topics = "test-show", groupId = "tag-service-1")
    @KafkaHandler // 카프카의 해당 토픽에서 메시지를 얻으면 실행되는 함수
    public void getTagMessage(String message) throws JsonProcessingException {
        KafkaMessage<Show> kafkaMessage = KafkaMessageUtils.deserialize(message, Show.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        showRepository.save(kafkaMessage.getBody());
    }
}
