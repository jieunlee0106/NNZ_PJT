package nnz.nanumservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.*;
import nnz.nanumservice.vo.NcpDeviceVO;
import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class NcpPushNotificationService {

    @Value("${ncp.push.access-key}")
    private String accessKey;

    @Value("${ncp.push.secret-key}")
    private String secretKey;

    @Value("${ncp.push.service-id}")
    private String serviceId;

    // 디바이스 등록
    public NcpDeviceDTO registDevice(NcpDeviceVO ncpDeviceVO) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException, URISyntaxException {

        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time, "POST", "/push/v2/services/" + serviceId + "/users"));

        NcpDeviceDTO request = NcpDeviceDTO.builder()
                .userId(ncpDeviceVO.getUserId().toString())
                .deviceType("GCM")
                .deviceToken(ncpDeviceVO.getDeviceToken())
                .isNotificationAgreement(true)
                .isAdAgreement(true)
                .isNightAdAgreement(true)
                .build();

        ObjectMapper om = new ObjectMapper();
        String body = om.writeValueAsString(request);

        HttpEntity<String> httpBody = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        return restTemplate.postForObject(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/users"),
                httpBody, NcpDeviceDTO.class
        );
    }

    // 디바이스 조회
    public ResponseEntity<NcpDeviceResponseDTO> getDevice(Long id) throws URISyntaxException, UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException {
        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time, "GET", "/push/v2/services/" + serviceId + "/users/" + id.toString()));

        HttpEntity<String> httpBody = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        ResponseEntity<NcpDeviceResponseDTO> exchange = restTemplate.exchange(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/users/" + id),
                HttpMethod.GET,
                httpBody,
                NcpDeviceResponseDTO.class
        );
        return exchange;
    }

    // 메시지 발송
    public void sendNcpPush(Long id) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException, URISyntaxException {
        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time, "POST", "/push/v2/services/" + serviceId + "/messages"));

        List<String> to = new ArrayList<>();
        to.add(id.toString());

        Map<String, String> custom = new HashMap<>();
        custom.put("title", "제목");
        custom.put("body", "내용");

        NcpMessageDTO request = NcpMessageDTO.builder()
                .target(NcpMessageDTO.Target.builder()
                        .type("USER")
                        .to(to)
                        .build())
                .message(NcpMessageDTO.Message.builder()
                        .defaultMessage(NcpMessageDTO.DefaultMessage.builder()
                                .content("5월 15일")
                                .custom(custom)
                                .build())
                        .build())
                .build();

        ObjectMapper om = new ObjectMapper();
        String body = om.writeValueAsString(request);

        HttpEntity<String> httpBody = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        JSONObject jsonObject = restTemplate.postForObject(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/messages"),
                httpBody, JSONObject.class
        );
        System.out.println(jsonObject);
    }

    public String makeSignature(Long time, String methodParam, String urlParam) throws NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeyException {
        String space = " ";					// one space
        String newLine = "\n";					// new line
        String method = methodParam;					// method
        String url = urlParam;	// url (include query string)
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

    // 디바이스 삭제
    public void deleteDevice(Long id) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, URISyntaxException {
        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time, "DELETE", "/push/v2/services/" + serviceId + "/users/" + id.toString()));

        HttpEntity<String> httpBody = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        ResponseEntity<NcpDeviceResponseDTO> exchange = restTemplate.exchange(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/users/" + id),
                HttpMethod.DELETE,
                httpBody,
                NcpDeviceResponseDTO.class
        );
    }

    // 디바이스 조회 결과
    public ResponseEntity<NcpMessageResultDTO> resultMessage(String id) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, URISyntaxException {
        Long time = System.currentTimeMillis();

        HttpHeaders headers = new HttpHeaders();
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", makeSignature(time, "GET", "/push/v2/services/" + serviceId + "/messages/" + id));

        HttpEntity<String> httpBody = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        ResponseEntity<NcpMessageResultDTO> exchange = restTemplate.exchange(
                new URI("https://sens.apigw.ntruss.com/push/v2/services/" + serviceId + "/messages/" + id),
                HttpMethod.GET,
                httpBody,
                NcpMessageResultDTO.class
        );
        return exchange;
    }
}
