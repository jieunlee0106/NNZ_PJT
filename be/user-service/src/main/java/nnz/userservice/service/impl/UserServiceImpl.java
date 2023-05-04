package nnz.userservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.TokenDTO;
import nnz.userservice.dto.UserDTO;
import nnz.userservice.entity.RefreshToken;
import nnz.userservice.entity.User;
import nnz.userservice.entity.VerifyNumber;
import nnz.userservice.exception.ErrorCode;
import nnz.userservice.repository.RefreshTokenRepository;
import nnz.userservice.repository.UserRepository;
import nnz.userservice.repository.VerifyNumberRepository;
import nnz.userservice.service.JwtProvider;
import nnz.userservice.service.KafkaProducer;
import nnz.userservice.service.UserService;
import nnz.userservice.util.ValidationUtils;
import nnz.userservice.vo.LoginVO;
import nnz.userservice.vo.UserJoinVO;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final VerifyNumberRepository verifyNumberRepository;
    private final PasswordEncoder passwordEncoder;
    private final KafkaProducer kafkaProducer;
    private final JwtProvider jwtProvider;
    private final RefreshTokenRepository refreshTokenRepository;

    @Override
    @Transactional
    public UserDTO join(UserJoinVO vo) throws UnsupportedEncodingException, JsonProcessingException {
        // 본인인증이 확인되었는지 체크
        VerifyNumber vn = verifyNumberRepository.findById(vo.getPhone())
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_VERIFY));

        if (!vn.isVerify()) {
            throw new CustomException(ErrorCode.NOT_VERIFIED);
        }

        // 이메일 형식 검사
        if (!ValidationUtils.isValidEmail(vo.getEmail())) {
            throw new CustomException(ErrorCode.INVALID_EMAIL_PATTERN);
        }

        // 이메일 중복 검사
        if (isExistByEmail(vo.getEmail())) {
            throw new CustomException(ErrorCode.DUPLICATE_EMAIL);
        }

        // 닉네임 형식 검사
        if (!ValidationUtils.isValidNickname(vo.getNickname())) {
            throw new CustomException(ErrorCode.INVALID_NICKNAME_PATTERN);
        }

        // 닉네임 중복 검사
        if (isExistByNickname(vo.getNickname())) {
            throw new CustomException(ErrorCode.DUPLICATE_NICKNAME);
        }

        // 비밀번호 형식 검사
        if (!ValidationUtils.isValidPwd(vo.getPwd())) {
            throw new CustomException(ErrorCode.INVALID_PWD_PATTERN);
        }

        // 비밀번호와 비밀번호 확인이 일치하는지 확인
        if (!vo.getPwd().equals(vo.getConfirmPwd())) {
            throw new CustomException(ErrorCode.PWD_NOT_MATCH_CONFIRM_PWD);
        }

        User newUser = User.builder()
                .email(vo.getEmail())
                .nickname(vo.getNickname())
                .phoneNumber(vo.getPhone())
                .password(passwordEncoder.encode(vo.getPwd()))
                .authProvider(User.AuthProvider.NNZ)
                .role(User.Role.USER)
                .build();

        newUser = userRepository.save(newUser);
        log.info("새로운 유저 가입: {}", newUser);

        UserDTO userDTO = UserDTO.of(newUser);

        // kafka에 가입한 사용자에 대한 메시지 발생
        kafkaProducer.sendMessage(userDTO);

        return userDTO;
    }

    @Override
    public boolean isExistByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public boolean isExistByNickname(String nickname) {
        return userRepository.existsByNickname(nickname);
    }

    @Override
    public TokenDTO login(LoginVO vo) {
        User user = userRepository.findByEmail(vo.getEmail())
                .orElseThrow(() -> new CustomException(ErrorCode.LOGIN_FAILURE));

        // 로그인 실패시 ErrorCode.LOGIN_FAILURE throw
        user.login(passwordEncoder, vo.getPwd());

        String accessToken = jwtProvider.generateAccessToken(user);
        String refreshToken = jwtProvider.generateRefreshToken(user);

        // 레디스에 리프레시 토큰 저장 -> key: email / value: refreshToken
        RefreshToken rt = RefreshToken.builder()
                .id(user.getEmail())
                .refreshToken(refreshToken)
                .build();
        refreshTokenRepository.save(rt);

        return TokenDTO.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }
}
