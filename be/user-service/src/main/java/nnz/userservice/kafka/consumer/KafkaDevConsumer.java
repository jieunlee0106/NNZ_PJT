package nnz.userservice.kafka.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;

@Slf4j
public class KafkaDevConsumer extends KafkaConsumer {

    public KafkaDevConsumer(KafkaMessageHandler handler) {
        super(handler);
    }

    @Override
    @KafkaListener(topics = "dev-nanum")
    public void consumeNanumMessage(String message) throws JsonProcessingException {
        super.consumeNanumMessage(message);
    }

    @Override
    @KafkaListener(topics = "dev-show-sync")
    public void consumeShowMessage(String message) throws JsonProcessingException {
        super.consumeShowMessage(message);
    }
}
