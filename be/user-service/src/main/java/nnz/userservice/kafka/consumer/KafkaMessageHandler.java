package nnz.userservice.kafka.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.NanumDTO;
import nnz.userservice.service.DBSynchronizer;
import nnz.userservice.service.impl.NanumSynchronizer;
import nnz.userservice.vo.sync.NanumSyncVO;
import org.springframework.stereotype.Service;

import java.util.Set;

import static io.github.eello.nnz.common.kafka.KafkaMessage.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaMessageHandler {

    private final NanumSynchronizer nanumSyncService;

    public void handleNanumMessage(String message) throws JsonProcessingException {
        KafkaMessage<NanumSyncVO> data = deserializeMessage(message, NanumSyncVO.class);
        KafkaMessageType messageType = getMessageType(data);
        NanumSyncVO body = getMessageBody(data);

        if (messageType == KafkaMessageType.CREATE) {
            nanumSyncService.create(body);
        } else if (messageType == KafkaMessageType.UPDATE) {
            nanumSyncService.update(body);
        } else nanumSyncService.delete(body);
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
