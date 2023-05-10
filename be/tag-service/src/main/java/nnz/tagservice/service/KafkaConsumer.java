package nnz.tagservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.tagservice.dto.NanumDTO;
import nnz.tagservice.dto.ShowDTO;
import nnz.tagservice.entity.Nanum;
import nnz.tagservice.entity.Show;
import nnz.tagservice.repository.NanumRepository;
import nnz.tagservice.repository.ShowRepository;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaConsumer {

    private final ShowRepository showRepository;
    private final NanumRepository nanumRepository;

    @KafkaListener(topics = "dev-show", groupId = "tag-service-1")
    public void getShowMessage(String message) throws JsonProcessingException {
        KafkaMessage<ShowDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ShowDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        Show show = Show.of(kafkaMessage.getBody());

        showRepository.save(show);
    }

    @KafkaListener(topics = "dev-nanum", groupId = "tag-service-2")
    public void getNanumMessage(String message) throws JsonProcessingException {
        KafkaMessage<NanumDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, NanumDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        Nanum nanum = Nanum.of(kafkaMessage.getBody());

        nanumRepository.save(nanum);
    }
}
