package nnz.userservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.sync.BookmarkSyncDTO;
import nnz.userservice.entity.Bookmark;
import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.User;
import nnz.userservice.exception.ErrorCode;
import nnz.userservice.kafka.KafkaProducer;
import nnz.userservice.repository.BookmarkRepository;
import nnz.userservice.repository.NanumRepository;
import nnz.userservice.repository.UserRepository;
import nnz.userservice.service.BookmarkService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BookmarkServiceImpl implements BookmarkService {

    private final UserRepository userRepository;
    private final NanumRepository nanumRepository;
    private final BookmarkRepository bookmarkRepository;
    private final KafkaProducer kafkaProducer;

    @Override
    @Transactional
    public void wish(Long userId, Long nanumId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Nanum nanum = nanumRepository.findById(nanumId)
                .orElseThrow(() -> new CustomException(ErrorCode.NANUM_NOT_FOUND));

        Bookmark bookmark = bookmarkRepository.findByUserAndNanum(user, nanum)
                .orElse(null);

        if (bookmark != null) { // 해당 나눔을 찜한 이력이 있으면
            if (bookmark.getIsDelete()) bookmark.reBookmark(); // 다시 찜
            else throw new CustomException(ErrorCode.ALREADY_BOOKMARKED); // 이미 찜한 나눔인 경우
        } else {
            bookmark = Bookmark.builder()
                    .user(user)
                    .nanum(nanum)
                    .build();

            bookmarkRepository.save(bookmark);
        }

        log.info("{}님이 '{}'를 찜", user.getEmail(), nanum.getTitle());
    }

    @Override
    @Transactional
    public void cancelWish(Long userId, Long nanumId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Nanum nanum = nanumRepository.findById(nanumId)
                .orElseThrow(() -> new CustomException(ErrorCode.NANUM_NOT_FOUND));

        Bookmark bookmark = bookmarkRepository.findByUserAndNanum(user, nanum)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_BOOKMARK));

        if (bookmark.getIsDelete()) {
            throw new CustomException(ErrorCode.NOT_BOOKMARK);
        }

        bookmark.cancel();

        log.info("{}님이 '{}'를 찜 해제", user.getEmail(), nanum.getTitle());
    }

    @Override
    @Transactional
    public void toggleWish(Long userId, Long nanumId) throws JsonProcessingException {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Nanum nanum = nanumRepository.findById(nanumId)
                .orElseThrow(() -> new CustomException(ErrorCode.NANUM_NOT_FOUND));

        Bookmark bookmark = bookmarkRepository.findByUserAndNanum(user, nanum)
                .orElse(null);

        KafkaMessage<BookmarkSyncDTO> kafkaMessage;
        if (bookmark != null) {
            if (bookmark.getIsDelete()) { // 찜했던 나눔이면
                bookmark.reBookmark();
                log.info("{}님이 '{}'를 찜", user.getEmail(), nanum.getTitle());
            } else { // 찜한 나눔이면 나눔 취소
                bookmark.cancel();
                log.info("{}님이 '{}'를 찜 해제", user.getEmail(), nanum.getTitle());
            }

            kafkaMessage = KafkaMessage.update().body(BookmarkSyncDTO.of(bookmark));
        } else {
            bookmark = Bookmark.builder()
                    .user(user)
                    .nanum(nanum)
                    .build();

            bookmarkRepository.save(bookmark);
            log.info("{}님이 '{}'를 찜", user.getEmail(), nanum.getTitle());

            kafkaMessage = KafkaMessage.create().body(BookmarkSyncDTO.of(bookmark));
        }

        kafkaProducer.sendMessage("bookmark", kafkaMessage);
    }
}
