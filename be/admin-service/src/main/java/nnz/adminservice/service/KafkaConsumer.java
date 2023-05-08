package nnz.adminservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.adminservice.dto.UserDTO;
import nnz.adminservice.entity.User;
import nnz.adminservice.repository.UserRepository;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaConsumer {
    private final UserRepository userRepository;

    // user 생성
    @KafkaListener(topics = "dev-user", groupId = "dev-admin-service")
    public void message(String message) throws JsonProcessingException {
        KafkaMessage<UserDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, UserDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        UserDTO body = kafkaMessage.getBody();

        if(kafkaMessage.getType().equals("CREATE")) userRepository.save(User.of(body));
        else if(kafkaMessage.getType().equals("UPDATE")) userRepository.save(User.of(body));
        else if(kafkaMessage.getType().equals("UPDATE")) userRepository.delete(User.of(body));
    }
}
