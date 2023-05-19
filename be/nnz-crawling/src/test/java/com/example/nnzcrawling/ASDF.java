package com.example.nnzcrawling;

import com.example.nnzcrawling.dto.ShowSyncDTO;
import com.example.nnzcrawling.entity.Show;
import com.example.nnzcrawling.repository.ShowRepository;
import com.example.nnzcrawling.service.KafkaProducer;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@SpringBootTest
public class ASDF {

    @Autowired
    private ShowRepository showRepository;

    @Autowired
    private KafkaProducer producer;

    @Test
    @Transactional
    public void test() throws JsonProcessingException {
        List<Show> shows = showRepository.findAll();

        for (Show show : shows) {
            KafkaMessage kafkaMessage = KafkaMessage.create().body(ShowSyncDTO.of(show));
            producer.sendMessage(kafkaMessage);
        }
    }
}
