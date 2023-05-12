package nnz.showservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.extern.slf4j.Slf4j;
import nnz.showservice.dto.NanumDTO;
import org.springframework.kafka.annotation.KafkaHandler;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@KafkaListener(topics = "dev-nanum", groupId = "show-service-1")
public class KafkaConsumer {

    @KafkaHandler // 카프카의 해당 토픽에서 메시지를 얻으면 실행되는 함수
    public void message(String message) throws JsonProcessingException {
        KafkaMessage<NanumDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, NanumDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        // logic
    }
}