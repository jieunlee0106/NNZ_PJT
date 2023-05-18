package nnz.showservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.showservice.dto.BannerDTO;
import nnz.showservice.dto.NanumDTO;
import nnz.showservice.dto.TagDTO;
import nnz.showservice.entity.Banner;
import nnz.showservice.entity.Nanum;
import nnz.showservice.entity.Show;
import nnz.showservice.entity.Tag;
import nnz.showservice.repository.BannerRepository;
import nnz.showservice.repository.NanumRepository;
import nnz.showservice.repository.ShowRepository;
import nnz.showservice.repository.TagRepository;
import org.springframework.data.domain.Page;
import org.springframework.kafka.annotation.KafkaHandler;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaConsumer {

    private final ShowRepository showRepository;
    private final NanumRepository nanumRepository;
    private final BannerRepository bannerRepository;
    private final TagRepository tagRepository;

    @Transactional
    @KafkaListener(topics = "dev-nanum", groupId = "show-service-1")
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

    @Transactional
    @KafkaListener(topics = "dev-banner", groupId = "show-service-2")
    public void getBannerMessage(String message) throws JsonProcessingException {
        KafkaMessage<BannerDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, BannerDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        Banner banner = null;

        // logic
        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            // todo: error handling
            Show show = showRepository.findById(kafkaMessage.getBody().getShowId()).orElseThrow();
            banner = Banner.builder()
                    .id(kafkaMessage.getBody().getId())
                    .show(show)
                    .image(kafkaMessage.getBody().getImage())
                    .updatedAt(kafkaMessage.getBody().getUpdatedAt())
                    .build();
            bannerRepository.save(banner);
        } //
        else if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.UPDATE) {
            banner = bannerRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();

            if (banner.getUpdatedAt().isAfter(kafkaMessage.getBody().getUpdatedAt())) {
                log.info("current banner is the latest.");
                return;
            }

            Show show = showRepository.findById(kafkaMessage.getBody().getShowId()).orElseThrow();
            banner.updateBanner(kafkaMessage.getBody(), show);
        } //
        else {
            banner = bannerRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            banner.deleteBanner(kafkaMessage.getBody().getUpdatedAt());
        }
    }

    @Transactional
    @KafkaListener(topics = "dev-tag-sync", groupId = "show-service-3")
    public void getTagMessage(String message) throws JsonProcessingException {
        KafkaMessage<TagDTO> data = KafkaMessageUtils.deserialize(message, TagDTO.class);
        KafkaMessage.KafkaMessageType type = data.getType();
        TagDTO body = data.getBody();

        if (type == KafkaMessage.KafkaMessageType.CREATE) {
            Optional<Tag> optTag = tagRepository.findById(body.getId());

            Tag tag;
            // id에 해당하는 값이 존재하지만 태그 이름이 다른 경우
            if (optTag.isPresent()) {
                tag = optTag.get();

                // 입력으로 들어온 메시지가 최신이면 업데이트
                if (body.getUpdatedAt().isAfter(tag.getUpdatedAt())) {
                    tag.updateTag(body.getTag());
                    tag.updateViews(body.getViews());
                }

                log.info("Tag Update Success: Tag: {}", tag);
            } else {
                tag = Tag.builder()
                        .id(body.getId())
                        .tag(body.getTag())
                        .views(body.getViews() == null ? 0 : body.getViews())
                        .build();

                tagRepository.save(tag);
                log.info("Tag Create Success: Tag: {}", tag);
            }
        }
    }
}