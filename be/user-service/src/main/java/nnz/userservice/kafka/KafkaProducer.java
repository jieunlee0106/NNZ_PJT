package nnz.userservice.kafka;

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

//    @Value("${spring.kafka.producer.topic}")
//    private String topic;

    @Value("${spring.kafka.prefix}")
    private String prefix;

    private final KafkaTemplate<String, String> kafkaTemplate;

    public void sendMessage(String topic, KafkaMessage<?> message) throws JsonProcessingException {
        String jsonMessage = KafkaMessageUtils.serialize(message);
        kafkaTemplate.send(prefix + topic, jsonMessage);
        log.info("produce message: {} to: {}", jsonMessage, prefix + topic);
    }
}
