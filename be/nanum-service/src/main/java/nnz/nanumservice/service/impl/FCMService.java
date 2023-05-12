package nnz.nanumservice.service.impl;

import com.google.common.*;
import com.google.firebase.messaging.*;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.FCMNotificationDTO;
import nnz.nanumservice.exception.ErrorCode;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.TimeZone;

@Service
@Slf4j
@RequiredArgsConstructor
public class FCMService {

//    private final FirebaseMessaging firebaseMessaging;

    public void sendMessage(FCMNotificationDTO fcmNotificationDTO){
        Notification notification = Notification.builder()
                .setTitle(fcmNotificationDTO.getTitle())
                .setBody(fcmNotificationDTO.getBody())
                .build();

        LocalDateTime plus = fcmNotificationDTO.getEventTime().plusHours(9);
        LocalDateTime minus = fcmNotificationDTO.getEventTime().minusHours(9);

        System.out.println(plus);
        System.out.println(minus);

        ZoneId zoneid = ZoneId.of("Asia/Seoul");
        long millis = minus.atZone(zoneid).toInstant().toEpochMilli();
        log.info(fcmNotificationDTO.getEventTime().toString());
        System.out.println("millis : " + millis);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS000000'Z'");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        String eventTime = dateFormat.format(new Date(millis));

        System.out.println("###########" + eventTime);
        log.info("######################## {}", eventTime);
        Message message = Message.builder()
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .setNotification(AndroidNotification.builder()
                                .setEventTimeInMillis(millis)
                                .build())
                        .build())
                .setToken(fcmNotificationDTO.getUserToken())
                .setNotification(notification)

                .build();

    }
}
