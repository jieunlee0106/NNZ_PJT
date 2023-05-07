package nnz.userservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.jwt.DecodedToken;
import lombok.RequiredArgsConstructor;
import nnz.userservice.dto.TokenDTO;
import nnz.userservice.service.FollowService;
import nnz.userservice.service.UserService;
import nnz.userservice.service.VerifyService;
import nnz.userservice.util.ValidationUtils;
import nnz.userservice.vo.*;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
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
    private final VerifyService verifyService;
    private final FollowService followService;

    @PostMapping("/users/join")
    public ResponseEntity<Void> join(@RequestBody UserJoinVO vo) throws UnsupportedEncodingException, JsonProcessingException {
        userService.join(vo);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/verify")
    public ResponseEntity<Void> sendMessage(@RequestBody VerifyVO vo) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        verifyService.sendVerifySms(vo.getPhone());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/users/verify/check")
    public ResponseEntity<Map<String, Boolean>> checkVerify(@RequestBody CheckVerifyVO vo) {
        boolean result = verifyService.verify(vo.getPhone(), vo.getVerifyNum());

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

    @PostMapping("/users/login")
    public ResponseEntity<TokenDTO> login(@RequestBody LoginVO vo, HttpServletResponse response) {
        TokenDTO token = userService.login(vo);
        ResponseCookie cookie = ResponseCookie.from("refresh", token.getRefreshToken())
                .httpOnly(true)
                .path("/")
                .build();

        response.addHeader("Set-Cookie", cookie.toString());
        token.deleteRefreshToken(); // 응답에 refreshToken을 포함시키지 않기 위해 null로 변경
        return ResponseEntity.ok(token);
    }

    @PostMapping("/users/follow/{followingId}")
    public ResponseEntity<Void> follow(@PathVariable Long followingId, DecodedToken token) {
        // 요청자(token.getId()) 가 followingId에 해당하는 사용자를 팔로우
        followService.follow(token.getId(), followingId);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/unfollow/{followingId}")
    public ResponseEntity<Void> unfollow(@PathVariable Long followingId, DecodedToken token) {
        // 요청자(token.getId()) 가 followingId에 해당하는 사용자를 언팔로우
        followService.unfollow(token.getId(), followingId);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/users/find-pwd")
    public ResponseEntity<Void> findPwd(@RequestBody FindPwdVO vo) {
        userService.findPwd(vo);
        return ResponseEntity.noContent().build();
    }
}