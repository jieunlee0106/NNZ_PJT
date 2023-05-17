package nnz.nanumservice.service.impl;

import com.google.firebase.messaging.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.FcmNotificationDTO;
import nnz.nanumservice.entity.Bookmark;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.UserNanum;
import nnz.nanumservice.repository.BookmarkRepository;
import nnz.nanumservice.repository.NanumRepository;
import nnz.nanumservice.repository.UserNanumRepository;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class FCMService {

    private final NanumRepository nanumRepository;
    private final UserNanumRepository userNanumRepository;
    private final BookmarkRepository bookmarkRepository;

    @Async
    public void sendMessage(FcmNotificationDTO fcmNotificationDTO) throws FirebaseMessagingException {
        Notification notification = Notification.builder()
                .setTitle(fcmNotificationDTO.getTitle())
                .setBody(fcmNotificationDTO.getBody())
                .build();

        Message message = Message.builder()
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .build())
                .setToken(fcmNotificationDTO.getUserToken())
                .setNotification(notification)
                .build();

        FirebaseMessaging.getInstance().sendAsync(message);
    }

    @Async
    public void sendMessage(String title, String body, String token) throws FirebaseMessagingException {
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(body)
                .build();

        Message message = Message.builder()
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .build())
                .setToken(token)
                .setNotification(notification)
                .build();

        FirebaseMessaging.getInstance().sendAsync(message);
    }

    @Async
    public void sendMultipleMessage(String title, String body, List<String> tokens) throws FirebaseMessagingException {
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(body)
                .build();

        List<Message> collect = tokens.stream().map(t -> Message.builder()
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .build())
                .setToken(t)
                .setNotification(notification)
                .build()).collect(Collectors.toList());

        FirebaseMessaging.getInstance().sendAllAsync(collect);
    }

    @Async
    @Scheduled(cron = "0 0 9 1/1 * ?")
    public void sendBookmarkNanumOpenPush() throws FirebaseMessagingException {
        // 매일 오전 9시
        // 오픈 당일인 나눔을 찾는다.
        LocalDate today = LocalDate.now();
        LocalDateTime start = LocalDateTime.of(today.getYear(), today.getMonth(), today.getDayOfMonth(), 0, 0, 0);
        LocalDateTime end = LocalDateTime.of(today.getYear(), today.getMonth(), today.getDayOfMonth(), 23, 59, 59);

        List<Nanum> allByOpenTime = nanumRepository.findAllByOpenTimeBetween(start, end);
        log.info("오늘 오픈하는 나눔의 수 : {}",  allByOpenTime.size());

        // 그 나눔들을 찜한 사람들을 찾는다.
        List<Bookmark> in = bookmarkRepository.findAllByNanumIn(allByOpenTime);
        log.info("알림 대상 북마크의 수 : {}", in.size());

        // 그 사람들의 토큰으로 알림을 보낸다.
        List<String> collect = in.stream().map(bookmark -> bookmark.getUser().getDeviceToken()).collect(Collectors.toList());

        if(collect.size() > 0)
            sendMultipleMessage("오늘 찜한 나눔이 오픈해요!",
                    "잊지말고 나너주를 찾아주세요",
                    collect);
    }

    @Async
    @Scheduled(cron = "0 0 9 1/1 * ?")
    public void sendReceiveNanumPush() throws FirebaseMessagingException {
        // 매일 오전 9시
        // 나눔 당일인 나눔을 찾는다.
        LocalDate today = LocalDate.now();
        List<Nanum> allByNanumDate = nanumRepository.findAllByNanumDate(today);
        log.info("오늘 나눔하는 나눔의 수 : {}",  allByNanumDate.size());

        // 그 나눔을 받을 사람들을 찾는다. isCertificated = true, isReceived = false 체크
        List<UserNanum> allByIsCertificatedAndIsReceivedAndNanumIn = userNanumRepository.findAllByIsCertificatedAndIsReceivedAndNanumIn(true, false, allByNanumDate);
        log.info("오늘 나눔에 참여하는 사람 수 : {}", allByIsCertificatedAndIsReceivedAndNanumIn.size());

        // 그 사람들의 토큰으로 알림을 보낸다.
        List<String> collect = allByIsCertificatedAndIsReceivedAndNanumIn.stream().map(userNanum -> userNanum.getReceiver().getDeviceToken()).collect(Collectors.toList());

        if(collect.size() > 0)
            sendMultipleMessage("신청한 나눔을 받는 날이에요!",
                    "나눔 당일 정보를 확인해주세요",
                    collect);
    }
}