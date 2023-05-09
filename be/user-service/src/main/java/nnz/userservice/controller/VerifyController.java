package nnz.userservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.service.VerifyService;
import nnz.userservice.vo.CheckVerifyVO;
import nnz.userservice.vo.VerifyVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
public class VerifyController {

    private final VerifyService verifyService;

    @PostMapping("/users/join/verify")
    public ResponseEntity<Void> sendJoinVerifyNumberMessage(@RequestBody VerifyVO vo) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        verifyService.sendJoinVerifySms(vo.getPhone());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/users/find-pwd/verify")
    public ResponseEntity<Void> sendFindPwdVerifyNumberMessage(@RequestBody VerifyVO vo) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        verifyService.sendFindPwdVerifySms(vo.getPhone());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/users/verify/check")
    public ResponseEntity<Map<String, Boolean>> checkVerify(@RequestBody CheckVerifyVO vo) {
        boolean result = verifyService.verify(vo.getPhone(), vo.getVerifyNum());

        Map<String, Boolean> response = new HashMap<>();
        response.put("verify", result);
        return ResponseEntity.ok(response);
    }
}
