package nnz.nanumservice.service.impl;

import com.google.firebase.messaging.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.FcmNotificationDTO;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.repository.NanumRepository;
import nnz.nanumservice.repository.UserNanumRepository;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class FCMService {

    private final NanumRepository nanumRepository;
    private final UserNanumRepository userNanumRepository;

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

        List<Message> messages = new ArrayList<>();
        tokens.stream().map(t-> Message.builder()
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .build())
                .setToken(t)
                .setNotification(notification)
                .build());

        FirebaseMessaging.getInstance().sendAllAsync(messages);
    }


    public void sendBookmarkNanumOpenPush(){
        // 매일 오전 9시
        // 오픈 당일인 나눔을 찾는다.
        LocalDate today = LocalDate.now();
        LocalDateTime start = LocalDateTime.of(today.getYear(), today.getMonth(), today.getDayOfMonth(), 0, 0, 0);
        LocalDateTime end = LocalDateTime.of(today.getYear(), today.getMonth(), today.getDayOfMonth(), 23, 59, 59);

        List<Nanum> allByOpenTime = nanumRepository.findAllByOpenTimeBetween(start, end);

        // 그 나눔들을 찜한 사람들을 찾는다.

        // 그 사람들의 토큰으로 알림을 보낸다.

        // 오늘 찜한 나눔이 오픈해요!
        // 잊지말고 나너주를 찾아주세요
    }

    public void sendReceiveNanumPush(){
        // 매일 오전 9시
        // 나눔 당일인 나눔을 찾는다.

        // 그 나눔을 받을 사람들을 찾는다. isCertificated = true, isReceived = false 체크

        // 그 사람들의 토큰으로 알림을 보낸다.

        // 신청한 나눔을 받는 날이에요!
        // 나눔 당일 정보를 확인해주세요
    }
}