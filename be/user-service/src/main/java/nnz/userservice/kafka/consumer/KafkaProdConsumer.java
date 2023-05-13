package nnz.userservice.kafka.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.kafka.annotation.KafkaListener;

public class KafkaProdConsumer extends KafkaConsumer {

    public KafkaProdConsumer(KafkaMessageHandler handler) {
        super(handler);
    }

    @Override
    @KafkaListener(topics = "prod-nanum")
    public void consumeNanumMessage(String message) throws JsonProcessingException {
        super.consumeNanumMessage(message);
    }

    @Override
    @KafkaListener(topics = "prod-show")
    public void consumeShowMessage(String message) throws JsonProcessingException {
        super.consumeShowMessage(message);
    }
}
