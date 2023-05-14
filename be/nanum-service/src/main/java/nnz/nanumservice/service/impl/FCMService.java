package nnz.nanumservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.messaging.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.FCMMessage;
import nnz.nanumservice.dto.FCMNotificationDTO;
import okhttp3.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders.*;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.*;

@Service
@Slf4j
@RequiredArgsConstructor
public class FCMService {

    private final String API_URL = "https://fcm.googleapis.com/v1/projects/naneozoo/messages:send";
    private final ObjectMapper objectMapper;
    private final FirebaseMessaging firebaseMessaging;


    public void sendMessage(FCMNotificationDTO fcmNotificationDTO) throws FirebaseMessagingException {
        Notification notification = Notification.builder()
                .setTitle(fcmNotificationDTO.getTitle())
                .setBody(fcmNotificationDTO.getBody())
                .build();

        long ttlSeconds = 60L;
        long sendTimeSeconds = Instant.now().getEpochSecond() + 60L;

        Message message = Message.builder()
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .setTtl(ttlSeconds)
                        .build())
                .setToken(fcmNotificationDTO.getUserToken())
                .setNotification(notification)
                .setApnsConfig(ApnsConfig.builder()
                        .setAps(Aps.builder()
                                .setBadge(1)
                                .build())
                        .build())
                .build();

        FirebaseMessaging.getInstance().send(message);
    }

    private String getAccessToken() throws IOException {
        ClassPathResource resource = new ClassPathResource("naneozoo-firebase-adminsdk-5cna1-e73447ff78.json");

        GoogleCredentials googleCredentials = GoogleCredentials.fromStream(resource.getInputStream())
                .createScoped(List.of("https://www.googleapis.com/auth/cloud-platform"));

        googleCredentials.refreshIfExpired();
        return googleCredentials.getAccessToken().getTokenValue();
    }

    public void sendMessgeTo(FCMNotificationDTO fcmNotificationDTO) throws IOException {
        String message = makeMessage(fcmNotificationDTO.getUserToken(), fcmNotificationDTO.getTitle(), fcmNotificationDTO.getBody());

        OkHttpClient client = new OkHttpClient();

//        RequestBody requestBody = RequestBody.create(message,
//                MediaType.get("application/json; charset=utf-8"));

        // set TTL and send_time
        long ttlSeconds = 60L;
        long sendTimeSeconds = Instant.now().getEpochSecond() + 60L;

        // create FCM message
        JSONObject fcmMessage = new JSONObject();
        fcmMessage.put("token", fcmNotificationDTO.getUserToken());
        fcmMessage.put("notification", new JSONObject()
                .put("title", "Example Notification")
                .put("body", "This is an example notification."));

        // create request body
        JSONObject requestBody = new JSONObject();
        requestBody.put("message", fcmMessage);
        requestBody.put("validate_only", false);
        requestBody.put("android", new JSONObject()
                .put("ttl", ttlSeconds + "s"));
        requestBody.put("apns", new JSONObject()
                .put("headers", new JSONObject()
                        .put("apns-expiration", sendTimeSeconds)));

        // create request
        Request request = new Request.Builder()
                .url(API_URL)
                .post(RequestBody.create(MediaType.parse("application/json"), requestBody.toString()))
                .addHeader("Authorization", "Bearer " + getAccessToken())
                .build();

//        Request request = new Request.Builder()
//                .url(API_URL)
//                .post(requestBody)
//                .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
//                .build();

        Response response = client.newCall(request)
                .execute();

        System.out.println(response.body().string());
    }

    private String makeMessage(String targetToken, String title, String body) throws JsonProcessingException {
        FCMMessage fcmMessage = FCMMessage.builder()
                .message(FCMMessage.Message.builder()
                        .token(targetToken)
                        .notification(FCMMessage.Notification.builder()
                                .title(title)
                                .body(body)
                                .image(null)
                                .build()
                        )
                        .build()
                )
                .validate_only(false)
                .build();

        return objectMapper.writeValueAsString(fcmMessage);
    }

    public void chatgpt(FCMNotificationDTO fcmNotificationDTO) throws IOException {
        // OAuth 2.0을 사용하여 Google 서비스 계정으로 인증
        GoogleCredentials credentials = GoogleCredentials.getApplicationDefault();
        credentials = credentials.createScoped(Arrays.asList("https://www.googleapis.com/auth/firebase.messaging"));
        AccessToken token = credentials.refreshAccessToken();
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token.getTokenValue());

        // 예약된 시간 생성
        String scheduledTime = "2023-05-15T10:00:00Z";

        // FCM 메시지 생성
        Map<String, Object> message = new HashMap<>();
        message.put("notification", new HashMap<String, Object>() {{
            put("title", "Title");
            put("body", "Body");
        }});
        message.put("token", fcmNotificationDTO.getUserToken());

        // FCM API 호출을 위한 요청 본문 생성
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("message", message);
        //requestBody.put("send_time", scheduledTime);
        requestBody.put("validate_only", false);

        // HTTP 요청 생성
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);
        RestTemplate restTemplate = new RestTemplate();

        // HTTP 요청 보내기
        String response = restTemplate.postForObject("https://fcm.googleapis.com/v1/projects/{project-id}/messages:send", requestEntity, String.class, "project-id");

        System.out.println("Successfully sent message: " + response);
    }
}
