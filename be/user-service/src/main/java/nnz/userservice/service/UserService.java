package nnz.userservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.userservice.dto.BookmarkedNanumDTO;
import nnz.userservice.dto.TokenDTO;
import nnz.userservice.dto.UserDTO;
import nnz.userservice.vo.FindPwdVO;
import nnz.userservice.vo.LoginVO;
import nnz.userservice.vo.UserJoinVO;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface UserService {

    UserDTO join(UserJoinVO vo) throws UnsupportedEncodingException, JsonProcessingException;
//    void sendVerifySms(String to) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException;
//    boolean verify(String phone, int verifyNumber);
    boolean isExistByEmail(String email);
    boolean isExistByNickname(String nickname);
    TokenDTO login(LoginVO vo);
    void findPwd(FindPwdVO vo);
    List<BookmarkedNanumDTO> findBookmarkedNanum(Long userId);
}
