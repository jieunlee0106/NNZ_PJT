package nnz.userservice.kafka.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public abstract class KafkaConsumer {

    public static final String KAFKA_GROUP_ID = "user-service-3";
    protected final KafkaMessageHandler handler;

    public void consumeNanumMessage(String message) throws JsonProcessingException {
        handler.handleNanumMessage(message);
    }

    public void consumeShowMessage(String message) throws JsonProcessingException {
        handler.handleShowMessage(message);
    }
}

