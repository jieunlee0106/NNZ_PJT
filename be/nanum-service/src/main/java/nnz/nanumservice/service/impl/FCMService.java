package nnz.nanumservice.service.impl;

import com.google.firebase.messaging.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.FcmNotificationDTO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class FCMService {

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

        FirebaseMessaging.getInstance().send(message);
    }

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

        FirebaseMessaging.getInstance().send(message);
    }

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

        FirebaseMessaging.getInstance().sendAll(messages);
    }
}
