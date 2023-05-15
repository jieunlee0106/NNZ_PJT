package nnz.nanumservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.FCMNotificationDTO;
import nnz.nanumservice.dto.NcpPushDTO;
import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class NcpPushNotificationService {

    @Value("${ncp.push.access-key}")
    private String accessKey;

    @Value("${ncp.push.secret-key}")
    private String secretKey;

    @Value("${ncp.push.service-id}")
    private String serviceId;

    public void registDevice(Long userId, String token) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException, URISyntaxException {

        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time));

        JSONObject request = new JSONObject();
        request.put("userId", userId);
        request.put("deviceType", "GCM");
        request.put("deviceToken", token);
        request.put("isNotificationAgreement", true);
        request.put("isAdAgreement", true);
        request.put("isNightAdAgreement", true);

        ObjectMapper om = new ObjectMapper();
        String body = om.writeValueAsString(request);

        HttpEntity<String> httpBody = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.postForObject(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/users"),
                httpBody, String.class
        );
    }

    public void sendNcpPush(FCMNotificationDTO fcmNotificationDTO) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException, URISyntaxException {
        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time));

        JSONObject request = new JSONObject();
        request.put("messageType", "AD");
        request.put("target.type", "USER");
        request.put("target.deviceType", "GCM");
        request.put("message", NcpPushDTO.builder().content("ncp에서 보내는 push").build());
        request.put("reserveTime", LocalDateTime.now().plusMinutes(1));

        ObjectMapper om = new ObjectMapper();
        String body = om.writeValueAsString(request);

        HttpEntity<String> httpBody = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.postForObject(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/messages"),
                httpBody, JSONObject.class
        );

    }

    public String makeSignature(Long time) throws NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeyException {
        String space = " ";					// one space
        String newLine = "\n";					// new line
        String method = "POST";					// method
        String url = "/push/v2/services/" + serviceId + "/users";	// url (include query string)
        String timestamp = time.toString();			// current timestamp (epoch)
        String accessKey = this.accessKey;			// access key id (from portal or Sub Account)
        String secretKey = this.secretKey;

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);

        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        String encodeBase64String = Base64.encodeBase64String(rawHmac);

        return encodeBase64String;
    }
}
