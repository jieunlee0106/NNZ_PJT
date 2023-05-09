package nnz.userservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.ShowRegisterVO;
import nnz.userservice.dto.UserReportVO;
import nnz.userservice.service.AskService;
import nnz.userservice.service.KafkaProducer;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AskServiceImpl implements AskService {

    private final KafkaProducer kafkaProducer;

    @Override
    public void askRegisterShow(ShowRegisterVO vo) throws JsonProcessingException {
        KafkaMessage kafkaMessage = KafkaMessage.create().body(vo);
        kafkaProducer.sendMessage("askedshow", kafkaMessage);
    }

    @Override
    public void reportUser(UserReportVO vo) throws JsonProcessingException {
        KafkaMessage kafkaMessage = KafkaMessage.create().body(vo);
        kafkaProducer.sendMessage("report", kafkaMessage);
    }
}
