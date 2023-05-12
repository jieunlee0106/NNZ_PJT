package nnz.adminservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.adminservice.dto.*;
import nnz.adminservice.entity.*;
import nnz.adminservice.exception.ErrorCode;
import nnz.adminservice.repository.*;
import org.springframework.context.annotation.Profile;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
@Profile("dev")
public class KafkaDevConsumer {
    private final UserRepository userRepository;
    private final ShowRepository showRepository;
    private final ReportRepository reportRepository;
    private final AskedShowRepository askedShowRepository;
    private final CategoryRepository categoryRepository;
    // User
    @KafkaListener(topics = "dev-user", groupId = "dev-admin-service")
    public void userMessage(String message) throws JsonProcessingException {
        KafkaMessage<UserDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, UserDTO.class);
        log.info("consume userMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        UserDTO body = kafkaMessage.getBody();

        if(Objects.equals(kafkaMessage.getType().toString(), "CREATE")) userRepository.save(User.of(body));
        else if(Objects.equals(kafkaMessage.getType().toString(), "UPDATE")) userRepository.save(User.of(body));
        else if(Objects.equals(kafkaMessage.getType().toString(), "DELETE")) userRepository.delete(User.of(body));
    }

    // Show
    @KafkaListener(topics = "dev-show-crawling", groupId = "dev-admin-service")
    public void showMessage(String message) throws JsonProcessingException {
        KafkaMessage<ShowDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ShowDTO.class);
        log.info("consume showMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        ShowDTO body = kafkaMessage.getBody();

        Category category = categoryRepository.findByName(body.getCategory())
                .orElseThrow(() -> new CustomException(ErrorCode.CATEGORY_NOT_FOUND));

        Show show = Show.builder()
                .title(body.getTitle())
                .category(category)
                .location(body.getLocation())
                .startDate(body.getStartDate())
                .endDate(body.getEndDate())
                .ageLimit(body.getAgeLimit())
                .region(body.getRegion())
                .posterImage(body.getPoster())
                .build();

        if(Objects.equals(kafkaMessage.getType().toString(), "CREATE")) showRepository.save(show);
        else if(Objects.equals(kafkaMessage.getType().toString(), "UPDATE")) showRepository.save(show);
        else if(Objects.equals(kafkaMessage.getType().toString(), "DELETE")) showRepository.delete(show);
    }

    // Report
    @KafkaListener(topics = "dev-report", groupId = "dev-admin-service")
    public void reportMessage(String message) throws JsonProcessingException {
        KafkaMessage<ReportDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ReportDTO.class);
        log.info("consume reportMessage: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        ReportDTO body = kafkaMessage.getBody();

        User reporter = userRepository.findById(body.getReporterId())
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

        if(Objects.equals(kafkaMessage.getType().toString(), "CREATE")) reportRepository.save(report);
        else if(Objects.equals(kafkaMessage.getType().toString(), "UPDATE")) reportRepository.save(report);
        else if(Objects.equals(kafkaMessage.getType().toString(), "DELETE")) reportRepository.delete(report);
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
                .createdBy(body.getCreatedBy())
                .build();

        if(Objects.equals(kafkaMessage.getType().toString(), "CREATE")) askedShowRepository.save(askedShow);
        else if(Objects.equals(kafkaMessage.getType().toString(), "UPDATE")) askedShowRepository.save(askedShow);
        else if(Objects.equals(kafkaMessage.getType().toString(), "DELETE")) askedShowRepository.delete(askedShow);
    }

}
