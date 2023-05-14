package nnz.showservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.showservice.dto.NanumDTO;
import nnz.showservice.entity.Nanum;
import nnz.showservice.entity.Show;
import nnz.showservice.repository.NanumRepository;
import nnz.showservice.repository.ShowRepository;
import org.springframework.data.domain.Page;
import org.springframework.kafka.annotation.KafkaHandler;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@KafkaListener(topics = "dev-nanum", groupId = "show-service-1")
public class KafkaConsumer {

    private final ShowRepository showRepository;
    private final NanumRepository nanumRepository;

    @KafkaHandler // 카프카의 해당 토픽에서 메시지를 얻으면 실행되는 함수
    @Transactional
    public void getNanumMessage(String message) throws JsonProcessingException {
        KafkaMessage<NanumDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, NanumDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        Nanum nanum = null;

        // logic
        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            // todo: error handling
            Show show = showRepository.findById(kafkaMessage.getBody().getShowId()).orElseThrow();
            nanum = Nanum.builder()
                    .id(kafkaMessage.getBody().getId())
                    .show(show)
                    .updatedAt(kafkaMessage.getBody().getUpdatedAt())
                    .build();
            nanumRepository.save(nanum);
        } //
        // 수정에 대한건 show service에서 굳이 필요 없을지도
        else if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.UPDATE) {
            nanum = nanumRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();

            if (nanum.getUpdatedAt().isAfter(kafkaMessage.getBody().getUpdatedAt())) {
                log.info("current nanum is the latest.");
                return;
            }

            Show show = showRepository.findById(kafkaMessage.getBody().getShowId()).orElseThrow();
            nanum.updateNanum(kafkaMessage.getBody().getUpdatedAt(), show);
        } //
        else {
            nanum = nanumRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            nanum.deleteNanum(kafkaMessage.getBody().getUpdatedAt());
        }
    }
}