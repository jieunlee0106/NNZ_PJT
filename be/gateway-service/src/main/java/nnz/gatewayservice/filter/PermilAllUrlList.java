package nnz.gatewayservice.filter;

import org.springframework.http.HttpMethod;

public class PermilAllUrlList {

    public static final String USER_SERVICE = "/user-service";
    public static final String NANUM_SERVICE = "/nanum-service";
    public static final String SHOW_SERVICE = "/show-service";
    public static final String ADMIN_SERVICE = "/admin-service";
    public static final String TAG_SERVICE = "/tag-service";

    private static final String[] getPermitAll = {
            // User Service
            USER_SERVICE + "/users/check", // 이메일, 닉네임 중복검사
            USER_SERVICE + "/users/{userId}", // 타유저 프로필 조회

            // Nanum Service
            NANUM_SERVICE + "/nanums/{nanumId}", // 나눔 상세 조회
            NANUM_SERVICE + "/nanums", // 나눔 조회
            NANUM_SERVICE + "/nanums/popular", // 인기 나눔 조회

//                "/search", // 검색
            // Show Service
            SHOW_SERVICE + "/shows/categories", // 카테고리 조회
            SHOW_SERVICE + "/shows/poster", // 배너 이미지 조회
            SHOW_SERVICE + "/shows", // 공연 조회
            SHOW_SERVICE + "/shows/{showId}", // 공연 상세 조회
            SHOW_SERVICE + "/shows/popular", // 인기 공연 조회

            // Tag Service
            TAG_SERVICE + "/tags", // 인기 해시태그 조회
    };

    private static final String[] postPermitAll = {
            // User Service
            USER_SERVICE + "/users/join", // 회원가입
            USER_SERVICE + "/users/join/verify", // 회원가입시 인증번호 발송
            USER_SERVICE + "/users/verify/check", // 인증번호 검증
            USER_SERVICE + "/users/login", // 로그인
            USER_SERVICE + "/users/find-pwd/verify", // 비밀번호 찾기 시 인증번호 발송
    };

    private static final String[] patchPermitAll = {
            // User Service
            USER_SERVICE + "/users/find-pwd", // 비밀번호 찾기시 비밀번호 변경
    };

    public static String[] findPermitAllUrl(HttpMethod method) {
        if (method == HttpMethod.GET) {
            return getPermitAll;
        } else if (method == HttpMethod.POST) {
            return postPermitAll;
        } else if (method == HttpMethod.PATCH) {
            return patchPermitAll;
        } else return null;
    }
}
