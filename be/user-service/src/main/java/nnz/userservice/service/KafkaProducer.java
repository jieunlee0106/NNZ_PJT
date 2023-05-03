package nnz.userservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectWriter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.UserDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaProducer {

    // TODO: ObjectWriter -> kafka json serialization 설정으로 해결

    @Value("${spring.kafka.producer.topic}")
    private String topic;

    private final KafkaTemplate<String, String> kafkaTemplate;
    private final ObjectWriter jsonWriter;

    public void sendMessage(UserDTO message) throws JsonProcessingException {
        kafkaTemplate.send(this.topic, jsonWriter.writeValueAsString(message));
        log.info("produce message: {} to: {}", message, this.topic);
    }
}
