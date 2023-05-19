package nnz.userservice.kafka.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public abstract class KafkaConsumer {

    protected final KafkaMessageHandler handler;

    public void consumeNanumMessage(String message) throws JsonProcessingException {
        handler.handleNanumMessage(message);
    }

    public void consumeShowMessage(String message) throws JsonProcessingException {
        handler.handleShowMessage(message);
    }

    public void consumeReceiveNanumMessage(String message) throws JsonProcessingException {
        handler.handleReceiveNanumMessage(message);
    }
}

