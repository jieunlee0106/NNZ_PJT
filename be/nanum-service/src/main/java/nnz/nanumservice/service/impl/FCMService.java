package nnz.nanumservice.service.impl;

import com.google.firebase.messaging.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.FcmNotificationDTO;
import org.springframework.stereotype.Service;

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
}
