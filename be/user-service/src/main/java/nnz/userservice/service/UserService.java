package nnz.userservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.userservice.dto.UserDTO;
import nnz.userservice.vo.UserJoinVO;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public interface UserService {

    UserDTO join(UserJoinVO vo) throws UnsupportedEncodingException;
    void sendVerifySms(String to) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException;
    boolean verify(String phone, int verifyNumber);
    boolean isExistByEmail(String email);
    boolean isExistByNickname(String nickname);
}
