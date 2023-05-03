package nnz.userservice.util;

import io.github.eello.nnz.common.exception.CustomException;
import org.junit.jupiter.api.Test;

import java.io.UnsupportedEncodingException;

import static org.junit.jupiter.api.Assertions.*;

class ValidationUtilsTest {

    @Test
    void email_pattern_test() {
//        assertThrows(CustomException.class, () -> ValidationUtils.isValidEmail("aaaa"));
//        assertDoesNotThrow(() -> ValidationUtils.isValidEmail("aaa@aa.a"));
    }

    @Test
    void nickname_pattern_test() throws UnsupportedEncodingException {
//        assertThrows(CustomException.class, () -> ValidationUtils.isValidNickname("가나다라마바사아자"));
//        assertThrows(CustomException.class, () -> ValidationUtils.isValidNickname("        "));
//        assertThrows(CustomException.class, () -> ValidationUtils.isValidNickname("aaaaaaaaaaaaaaaaa"));
//        assertThrows(CustomException.class, () -> ValidationUtils.isValidNickname("가나다랍바ㅏ"));
//        assertThrows(CustomException.class, () -> ValidationUtils.isValidNickname("가나다랍바ㅂ"));
//
//        assertDoesNotThrow(() -> ValidationUtils.isValidNickname("a"));
//        assertDoesNotThrow(() -> ValidationUtils.isValidNickname("가"));
//        assertDoesNotThrow(() -> ValidationUtils.isValidNickname("가나다라마바사아")); // 한글 8글자
//        assertDoesNotThrow(() -> ValidationUtils.isValidNickname("aaaaaaaaaaaaaaaa")); // 영문 16글자
    }

    @Test
    void pwd_pattern_test() {
        assertFalse(ValidationUtils.isValidPwd("A123"));
        assertTrue(ValidationUtils.isValidPwd("Aaa123@!!@#"));
        assertFalse(ValidationUtils.isValidPwd("1234"));
        assertTrue(ValidationUtils.isValidPwd("jS@#^^2039"));
    }

}