package nnz.userservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.dto.MessageDTO;
import nnz.userservice.entity.VerifyNumber;
import nnz.userservice.exception.ErrorCode;
import nnz.userservice.repository.VerifyNumberRepository;
import nnz.userservice.service.SmsSender;
import nnz.userservice.service.VerifyService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.Random;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class VerifyServiceImpl implements VerifyService {

    private final SmsSender smsSender;
    private final VerifyNumberRepository verifyNumberRepository;
    private static final Long VERIFY_NUMBER_EXPIRATION_PERIOD = 1000L * 60 * 2; // 2min

    @Override
    @Transactional
    public void sendVerifySms(String to) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        String randomNumber = createRandomNumber();

        // 인증번호를 문자로 전송
        MessageDTO messageDTO = MessageDTO.builder()
                .to(to)
                .content("NNZ 인증번호: " + randomNumber)
                .build();
        smsSender.sendMessage(messageDTO);


        // VerifyNumber 만료기간
        Date now = new Date();
        LocalDateTime expiration = LocalDateTime.ofInstant(
                new Date(now.getTime() + VERIFY_NUMBER_EXPIRATION_PERIOD).toInstant(),
                ZoneId.systemDefault()
        );

        // 인증 확인 및 회원가입시 인증 여부 확인하기 위해
        // 인증번호 redis에 저장
        VerifyNumber verifyNumber = VerifyNumber.builder()
                .phone(to)
                .verifyNumber(Integer.parseInt(randomNumber))
                .isVerify(false)
                .expirationDateTime(expiration)
                .build();
        verifyNumberRepository.save(verifyNumber);
        log.info("레디스에 인증정보 저장: {}", verifyNumber);
    }

    @Override
    @Transactional
    public boolean verify(String phone, int verifyNumber) {
        VerifyNumber vn = verifyNumberRepository.findById(phone)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_VERIFY));

        vn.verify(verifyNumber);
        verifyNumberRepository.save(vn);

        log.info("input verifyNumber:{}, {}의 인증결과: {}", verifyNumber, phone, vn.isVerify());
        return vn.isVerify();
    }

    private String createRandomNumber() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(999999));
    }
}
