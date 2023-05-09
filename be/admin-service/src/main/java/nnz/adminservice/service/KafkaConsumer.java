package nnz.adminservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.adminservice.dto.*;
import nnz.adminservice.entity.AskedShow;
import nnz.adminservice.entity.Report;
import nnz.adminservice.entity.Show;
import nnz.adminservice.entity.User;
import nnz.adminservice.exception.ErrorCode;
import nnz.adminservice.repository.AskedShowRepository;
import nnz.adminservice.repository.ReportRepository;
import nnz.adminservice.repository.ShowRepository;
import nnz.adminservice.repository.UserRepository;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class KafkaConsumer {
    private final UserRepository userRepository;
    private final ShowRepository showRepository;
    private final ReportRepository reportRepository;
    private final AskedShowRepository askedShowRepository;
    // User
    @KafkaListener(topics = "dev-user", groupId = "dev-admin-service")
    public void userMessage(String message) throws JsonProcessingException {
        KafkaMessage<UserDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, UserDTO.class);
        log.info("consume userMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        UserDTO body = kafkaMessage.getBody();

        if(Objects.equals(kafkaMessage.getType().toString(), "CREATE")) userRepository.save(User.of(body));
        else if(kafkaMessage.getType().equals("UPDATE")) userRepository.save(User.of(body));
        else if(kafkaMessage.getType().equals("DELETE")) userRepository.delete(User.of(body));
    }

    // Show
    @KafkaListener(topics = "dev-show", groupId = "dev-admin-service")
    public void showMessage(String message) throws JsonProcessingException {
        KafkaMessage<ShowDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ShowDTO.class);
        log.info("consume showMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        ShowDTO body = kafkaMessage.getBody();

        if(kafkaMessage.getType().equals("CREATE")) showRepository.save(Show.of(body));
        else if(kafkaMessage.getType().equals("UPDATE")) showRepository.save(Show.of(body));
        else if(kafkaMessage.getType().equals("DELETE")) showRepository.delete(Show.of(body));
    }

    // Report
    @KafkaListener(topics = "dev-report", groupId = "dev-admin-service")
    public void reportMessage(String message) throws JsonProcessingException {
        KafkaMessage<ReportDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ReportDTO.class);
        log.info("consume reportMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        ReportDTO body = kafkaMessage.getBody();

        User reporter = userRepository.findById(body.getReportedId())
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        User target = userRepository.findById(body.getTargetId())
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Report report = Report.builder()
                .reporter(reporter)
                .target(target)
                .reason(body.getReason())
                .reportedAt(body.getReportedAt())
                .status(Report.ReportStatus.of(body.getStatus()))
                .build();

        if(kafkaMessage.getType().equals("CREATE")) reportRepository.save(report);
        else if(kafkaMessage.getType().equals("UPDATE")) reportRepository.save(report);
        else if(kafkaMessage.getType().equals("DELETE")) reportRepository.delete(report);
    }

    // AskedShow
    @KafkaListener(topics = "dev-askedshow", groupId = "dev-admin-service")
    public void askedShowMessage(String message) throws JsonProcessingException {
        KafkaMessage<AskedShowKafkaDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, AskedShowKafkaDTO.class);
        log.info("consume askedShowMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        AskedShowKafkaDTO body = kafkaMessage.getBody();

        AskedShow askedShow = AskedShow.builder()
                .title(body.getTitle())
                .path(body.getPath())
                .status(AskedShow.AskedShowStatus.of(body.getStatus()))
                .build();

        if(Objects.equals(kafkaMessage.getType().toString(), "CREATE")) askedShowRepository.save(askedShow);
        else if(kafkaMessage.getType().equals("UPDATE")) askedShowRepository.save(askedShow);
        else if(kafkaMessage.getType().equals("DELETE")) askedShowRepository.delete(askedShow);
    }

}
