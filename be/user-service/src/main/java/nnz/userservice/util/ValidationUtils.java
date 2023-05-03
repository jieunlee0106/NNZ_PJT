package nnz.userservice.util;

import org.springframework.util.StringUtils;

import java.io.UnsupportedEncodingException;
import java.util.regex.Pattern;

public class ValidationUtils {

    /**
     * 이메일 형식 검사
     */
    public static boolean isValidEmail(String input) {
        String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
        Pattern p = Pattern.compile(regex);

        if (!p.matcher(input).matches()) {
            return false;
        }

        return true;
    }

    /**
     * 닉네임 형식 검사
     * - 최대 16Bytes
     * - 특수문자 사용 불가
     * - 공백 불가
     * - 단일 자음 또는 모음 불가(한글)
     */
    public static boolean isValidNickname(String input) throws UnsupportedEncodingException {
        // 공백 문자열이거나 총 16Bytes가 넘는지 검사
        if (!StringUtils.hasText(input) || input.getBytes("euc-kr").length > 16) {
            return false;
        }

        Pattern p1 = Pattern.compile(".*[ㄱ-ㅎ|ㅏ-ㅣ]+.*"); // 단일 자음 또는 모음 체크
        Pattern p2 = Pattern.compile("[ !@#$%^&*(),.?\":{}|<>]"); // 공백 포함 특수문자 체크
        if (p1.matcher(input).matches() || p2.matcher(input).find()) {
            return false;
        }

        return true;
    }

    /**
     * 비밀번호 형식 검사
     * - 최소 8자리에 숫자, 문자, 특수문자 각각 1개 이상 포함
     */
    public static boolean isValidPwd(String input) {
        // 최소 8자리에 숫자, 문자, 특수문자 각각 1개 이상 포함
        Pattern p1 = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$^!%*#?&]{8,}$");
        if (!p1.matcher(input).matches()) {
            return false;
        }

        return true;
    }
}
