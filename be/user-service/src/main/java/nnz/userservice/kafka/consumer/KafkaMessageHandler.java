package nnz.userservice.kafka.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.service.impl.NanumSynchronizer;
import nnz.userservice.service.impl.ReceiveNanumSynchronizer;
import nnz.userservice.service.impl.ShowSynchronizer;
import nnz.userservice.vo.sync.ReceiveNanumSyncVO;
import nnz.userservice.vo.sync.ShowSyncVO;
import nnz.userservice.vo.sync.NanumSyncVO;
import org.springframework.stereotype.Service;

import static io.github.eello.nnz.common.kafka.KafkaMessage.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaMessageHandler {

    private final NanumSynchronizer nanumSynchronizer;
    private final ShowSynchronizer showSynchronizer;
    private final ReceiveNanumSynchronizer receiveNanumSynchronizer;

    public void handleNanumMessage(String message) throws JsonProcessingException {
        KafkaMessage<NanumSyncVO> data = deserializeMessage(message, NanumSyncVO.class);
        KafkaMessageType messageType = getMessageType(data);
        NanumSyncVO body = getMessageBody(data);

        if (messageType == KafkaMessageType.CREATE) {
            nanumSynchronizer.create(body);
        } else if (messageType == KafkaMessageType.UPDATE) {
            nanumSynchronizer.update(body);
        } else nanumSynchronizer.delete(body);
    }

    public void handleShowMessage(String message) throws JsonProcessingException {
        KafkaMessage<ShowSyncVO> data = deserializeMessage(message, ShowSyncVO.class);
        KafkaMessageType messageType = getMessageType(data);
        ShowSyncVO body = getMessageBody(data);

        if (messageType == KafkaMessageType.CREATE) {
            showSynchronizer.create(body);
        } else if (messageType == KafkaMessageType.UPDATE) {
            showSynchronizer.update(body);
        } else showSynchronizer.delete(body);
    }

    public void handleReceiveNanumMessage(String message) throws JsonProcessingException {
        KafkaMessage<ReceiveNanumSyncVO> data = deserializeMessage(message, ReceiveNanumSyncVO.class);
        KafkaMessageType messageType = getMessageType(data);
        ReceiveNanumSyncVO body = getMessageBody(data);

        if (messageType == KafkaMessageType.CREATE) {
            receiveNanumSynchronizer.create(body);
        } else if (messageType == KafkaMessageType.UPDATE) {
            receiveNanumSynchronizer.update(body);
        } else receiveNanumSynchronizer.delete(body);
    }

    private <T> KafkaMessage<T> deserializeMessage(String message, Class<T> clazz) throws JsonProcessingException {
        return KafkaMessageUtils.deserialize(message, clazz);
    }
    private KafkaMessageType getMessageType(KafkaMessage<?> message) {
        return message.getType();
    }

    private <T> T getMessageBody(KafkaMessage<T> message) {
        return message.getBody();
    }
}
