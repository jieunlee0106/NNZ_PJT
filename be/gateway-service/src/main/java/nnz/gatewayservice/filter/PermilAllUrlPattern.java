package nnz.gatewayservice.filter;

import org.springframework.http.HttpMethod;

import java.util.regex.Pattern;

public class PermilAllUrlPattern {

    public static final String USER_SERVICE = "^/user-service";
    public static final String NANUM_SERVICE = "^/nanum-service";
    public static final String SHOW_SERVICE = "^/show-service";
    public static final String ADMIN_SERVICE = "^/admin-service";
    public static final String TAG_SERVICE = "^/tag-service";
    public static final String ID_PATH_VARIABLE = "/[0-9]+$";

    private static final Pattern[] getPermitAllPatterns = {
            // User Service
            Pattern.compile(USER_SERVICE + "/users/check"), // 이메일, 닉네임 중복검사
            Pattern.compile(USER_SERVICE + "/users" + ID_PATH_VARIABLE), // 타유저 프로필 조회

            // Nanum Service
            Pattern.compile(NANUM_SERVICE + "/nanums" + ID_PATH_VARIABLE), // 나눔 상세 조회
            Pattern.compile(NANUM_SERVICE + "/nanums"), // 나눔 조회
            Pattern.compile(NANUM_SERVICE + "/nanums/popular"), // 인기 나눔 조회
            Pattern.compile(NANUM_SERVICE + "/nanums/location"), // 위치기반 즉시 가능 나눔 조회

//                "/search", // 검색
            // Show Service
            Pattern.compile(SHOW_SERVICE + "/shows/categories"), // 카테고리 조회
            Pattern.compile(SHOW_SERVICE + "/shows/poster"), // 배너 이미지 조회
            Pattern.compile(SHOW_SERVICE + "/shows"), // 공연 조회
            Pattern.compile(SHOW_SERVICE + "/shows" + ID_PATH_VARIABLE), // 공연 상세 조회
            Pattern.compile(SHOW_SERVICE + "/shows/popular"), // 인기 공연 조회

            // Tag Service
            Pattern.compile(TAG_SERVICE + "/tags"), // 인기 해시태그 조회
            Pattern.compile(TAG_SERVICE + "/tags/search"), // 태그 검색
    };

    private static final Pattern[] postPermitAllPatterns = {
            // User Service
            Pattern.compile(USER_SERVICE + "/users/join"), // 회원가입
            Pattern.compile(USER_SERVICE + "/users/join/verify"), // 회원가입시 인증번호 발송
            Pattern.compile(USER_SERVICE + "/users/verify/check"), // 인증번호 검증
            Pattern.compile(USER_SERVICE + "/users/login"), // 로그인
            Pattern.compile(USER_SERVICE + "/users/find-pwd/verify"), // 비밀번호 찾기 시 인증번호 발송
    };

    private static final Pattern[] patchPermitAllPatterns = {
            // User Service
            Pattern.compile(USER_SERVICE + "/users/find-pwd"), // 비밀번호 찾기시 비밀번호 변경
    };

    private static final Pattern[] deletePermitAllPatterns = {};

    public static Pattern[] getPermitAllPatternBy(HttpMethod method) {
        if (method == HttpMethod.GET) {
            return getPermitAllPatterns;
        } else if (method == HttpMethod.POST) {
            return postPermitAllPatterns;
        } else if (method == HttpMethod.PATCH) {
            return patchPermitAllPatterns;
        } else return deletePermitAllPatterns;
    }
}
