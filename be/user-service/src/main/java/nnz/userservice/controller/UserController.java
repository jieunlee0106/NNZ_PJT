package nnz.userservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import nnz.userservice.service.UserService;
import nnz.userservice.util.ValidationUtils;
import nnz.userservice.vo.CheckVerifyVO;
import nnz.userservice.vo.UserJoinVO;
import nnz.userservice.vo.VerifyVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/users/join")
    public ResponseEntity<Void> join(@RequestBody UserJoinVO vo) throws UnsupportedEncodingException, JsonProcessingException {
        userService.join(vo);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/verify")
    public ResponseEntity<Void> sendMessage(@RequestBody VerifyVO vo) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        userService.sendVerifySms(vo.getPhone());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/users/verify/check")
    public ResponseEntity<Map<String, Boolean>> checkVerify(@RequestBody CheckVerifyVO vo) {
        boolean result = userService.verify(vo.getPhone(), vo.getVerifyNum());

        Map<String, Boolean> response = new HashMap<>();
        response.put("verify", result);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/users/check")
    public ResponseEntity<Map<String, Boolean>> duplicateCheck(
            @RequestParam("type") String type,
            @RequestParam("val") String val) throws UnsupportedEncodingException {
        boolean available = false;
        if ("email".equals(type)) {
            available = ValidationUtils.isValidEmail(val) && !userService.isExistByEmail(val);
        } else if ("nickname".equals(type)) {
            available = ValidationUtils.isValidNickname(val) && !userService.isExistByNickname(val);
        }

        Map<String, Boolean> response = new HashMap<>();
        response.put("available", available); // 존재하면 사용 불가능이므로 not 연산하여 응답
        return ResponseEntity.ok(response);
    }
}