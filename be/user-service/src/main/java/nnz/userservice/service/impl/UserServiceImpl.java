package nnz.userservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.MessageDTO;
import nnz.userservice.dto.UserDTO;
import nnz.userservice.entity.User;
import nnz.userservice.entity.VerifyNumber;
import nnz.userservice.exception.ErrorCode;
import nnz.userservice.repository.UserRepository;
import nnz.userservice.repository.VerifyNumberRepository;
import nnz.userservice.service.KafkaProducer;
import nnz.userservice.service.SmsSender;
import nnz.userservice.service.UserService;
import nnz.userservice.util.ValidationUtils;
import nnz.userservice.vo.UserJoinVO;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    private final SmsSender smsSender;
    private final UserRepository userRepository;
    private final VerifyNumberRepository verifyNumberRepository;
    private final PasswordEncoder passwordEncoder;
    private final KafkaProducer kafkaProducer;

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
                .build();

        newUser = userRepository.save(newUser);
        log.info("새로운 유저 가입: {}", newUser);

        UserDTO userDTO = UserDTO.of(newUser);

        // kafka에 가입한 사용자에 대한 메시지 발생
        kafkaProducer.sendMessage(userDTO);

        return userDTO;
    }

    @Override
    @Transactional
    public void sendVerifySms(String to) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        String randomNumber = createRandomNumber();

        // 인증번호를 문자로 전송
        // TODO: NCP-SMS 인증문제 해결 후 문자 보내도록 수
        MessageDTO messageDTO = MessageDTO.builder()
                .to(to)
                .content(randomNumber)
                .build();
//        smsSender.sendMessage(messageDTO);

        // 인증번호 redis에 저장
        // 인증 확인 및 회원가입시 인증 여부 확인하기 위해
        VerifyNumber verifyNumber = VerifyNumber.builder()
                .phone(to)
                .verifyNumber(Integer.parseInt(randomNumber))
                .isVerify(false)
                .build();
        verifyNumberRepository.save(verifyNumber);
        log.info("레디스에 인증정보 저장: {}", verifyNumber);
    }

    @Override
    @Transactional
    public boolean verify(String phone, int verifyNumber) {
        VerifyNumber vn = verifyNumberRepository.findById(phone)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_VERIFY));

        if (vn.getVerifyNumber() == verifyNumber) {
            vn.verify();
            verifyNumberRepository.save(vn);
        }

        log.info("input verifyNumber:{}, {}의 인증결과: {}", verifyNumber, phone, vn.isVerify());

        return vn.isVerify();
    }

    @Override
    public boolean isExistByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public boolean isExistByNickname(String nickname) {
        return userRepository.existsByNickname(nickname);
    }

    private String createRandomNumber() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(999999));
    }
}
