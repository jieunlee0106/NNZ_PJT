package nnz.nanumservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import io.github.eello.nnz.common.kafka.KafkaMessageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.*;
import nnz.nanumservice.entity.*;
import nnz.nanumservice.repository.*;
import nnz.nanumservice.vo.TagSyncVO;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class KafkaConsumer {

    private final ShowRepository showRepository;
    private final UserRepository userRepository;
    private final BookmarkRepository bookmarkRepository;
    private final NanumRepository nanumRepository;
    private final FollowerRepository followerRepository;
    private final TagRepository tagRepository;

    @Transactional
    @KafkaListener(topics = {"dev-show", "dev-show-admin"}, groupId = "nanum-service-1")
    public void getShowMessage(String message) throws JsonProcessingException {
        KafkaMessage<ShowDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, ShowDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        Show show = null;
        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            show = Show.of(kafkaMessage.getBody());
            showRepository.save(show);
        } //
        else if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.UPDATE) {
            show = showRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            show.updateShow(kafkaMessage.getBody());
        } //
        else {
            show = showRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            show.deleteShow();
        }
    }

    @Transactional
    @KafkaListener(topics = "dev-tag", groupId = "nanum-service-2")
    public void getTagMessage(String message) throws JsonProcessingException {
        KafkaMessage<TagSyncVO> data = KafkaMessageUtils.deserialize(message, TagSyncVO.class);
        KafkaMessage.KafkaMessageType type = data.getType();
        TagSyncVO body = data.getBody();

        // 조회수 동기화
        if (type == KafkaMessage.KafkaMessageType.UPDATE) {
            Optional<Tag> optTag = tagRepository.findById(body.getId());

            if (optTag.isEmpty()) {
                log.warn("태그 id: {}에 해당하는 태그가 존재하지 않습니다.", body.getId());
                return;
            }

            Tag tag = optTag.get();
            if (tag.getViews() < body.getViews()) {
                log.info("태그 id: {}의 조회수 업데이트 before: {} -> after {}", tag.getId(), tag.getViews(), body.getViews());
                tag.updateViews(body.getViews());
            }
        }

        log.info("Tag Update Success!");
    }

    @Transactional
    @KafkaListener(topics = "dev-user", groupId = "nanum-service-2")
    public void getUserMessage(String message) throws JsonProcessingException {
        KafkaMessage<UserDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, UserDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        User user = null;

        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            user = User.of(kafkaMessage.getBody());
            userRepository.save(user);
        } //
        else if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.UPDATE) {
            user = userRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            user.updateUser(kafkaMessage.getBody());
        } //
        else {
            user = userRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            user.deleteUser();
        }
    }

    @Transactional
    @KafkaListener(topics = "dev-bookmark", groupId = "nanum-service-3")
    public void getBookmarkMessage(String message) throws JsonProcessingException {
        KafkaMessage<BookmarkDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, BookmarkDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());
        log.info("kafkaMessage.getBody() = {}", kafkaMessage.getBody());

        Bookmark bookmark = null;

        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            // todo: error handling
            Nanum nanum = nanumRepository.findById(kafkaMessage.getBody().getNanumId()).orElseThrow();
            User user = userRepository.findById(kafkaMessage.getBody().getUserId()).orElseThrow();
            bookmark = Bookmark.of(kafkaMessage.getBody(), nanum, user);
            bookmarkRepository.save(bookmark);
        } //
        else if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.UPDATE) {
            bookmark = bookmarkRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();

            if (bookmark.getUpdatedAt().isAfter(kafkaMessage.getBody().getUpdatedAt())) {
                log.info("current bookmark is the latest.");
                return;
            }

            Nanum nanum = nanumRepository.findById(kafkaMessage.getBody().getNanumId()).orElseThrow();
            User user = userRepository.findById(kafkaMessage.getBody().getUserId()).orElseThrow();
            bookmark.updateBookmark(kafkaMessage.getBody(), nanum, user);
        } //
        else {
            bookmark = bookmarkRepository.findById(kafkaMessage.getBody().getId()).orElseThrow();
            bookmark.deleteBookmark();
        }
    }

    @Transactional
    @KafkaListener(topics = "dev-follow", groupId = "nanum-service-4")
    public void getFollowMessage(String message) throws JsonProcessingException {
        KafkaMessage<FollowerSyncDTO> kafkaMessage = KafkaMessageUtils.deserialize(message, FollowerSyncDTO.class);
        log.info("consume message: {}", message);
        log.info("kafkaMessage.getType() = {}", kafkaMessage.getType());

        FollowerSyncDTO body = kafkaMessage.getBody();
        log.info("kafkaMessage.getBody() = {}", body);

        User follower = userRepository.findById(body.getFollowerId()).orElse(null);
        if (follower == null) {
            log.warn("follower id에 해당하는 유저 없음.");
            return;
        }

        User following = userRepository.findById(body.getFollowingId()).orElse(null);
        if (following == null) {
            log.warn("following id에 해당하는 유저 없음.");
            return;
        }

        if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.CREATE) {
            // todo: error handling
            Follower build = Follower.builder()
                    .id(body.getId())
                    .following(following)
                    .follower(follower)
                    .updatedAt(body.getUpdatedAt())
                    .isDelete(body.getIsDelete())
                    .build();

            followerRepository.save(build);

        } //
        else if (kafkaMessage.getType() == KafkaMessage.KafkaMessageType.UPDATE) {
            Optional<Follower> optFollower = followerRepository.findById(body.getId());
            if (optFollower.isEmpty()) {
                Follower build = Follower.builder()
                        .id(body.getId())
                        .following(following)
                        .follower(follower)
                        .updatedAt(body.getUpdatedAt())
                        .isDelete(body.getIsDelete())
                        .build();

                followerRepository.save(build);
            } else {
                if (optFollower.get().getUpdatedAt().isAfter(body.getUpdatedAt())) {
                    log.info("current follow is the latest.");
                    return;
                }

                optFollower.get().update(body, follower, following);
            }
        } //
        else {
            followerRepository.findById(body.getId()).ifPresent(Follower::delete);
        }
    }
}