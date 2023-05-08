package nnz.tagservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaProducer {

    private final KafkaTemplate<String, String> kafkaTemplate;

    public void sendMessage(KafkaMessage<?> message, String topic) throws JsonProcessingException {
        String jsonMessage = KafkaMessageUtils.serialize(message); // 카프카 메시지 직렬화
        kafkaTemplate.send(topic, jsonMessage); // 해당 토픽에 jsonMessage 전송
        log.info("produce message: {} to: {}", jsonMessage, topic);
    }
}
