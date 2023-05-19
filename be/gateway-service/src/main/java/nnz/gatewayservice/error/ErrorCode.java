package nnz.gatewayservice.error;

public enum ErrorCode {

    NO_AUTHORIZATION_ATTR("AUTH001", "헤더에 Authorization 속성이 존재하지 않습니다."),
    MALFORMED_JWT("AUTH002", "유효하지 않은 토큰입니다."),
    EXPIRED_JWT("AUTH003", "만료된 토큰입니다."),
    UNSUPPORTED_JWT("AUTH004", "지원되지 않는 토큰입니다."),
    INVALID_JWT("AUTH005", "잘못된 토큰입니다."),
    EMPTY_JWT("AUTH006", "토큰이 존재하지 않습니다."),

    FORBIDDEN("AUTH007", "접근 권한이 없습니다."),
    ;

    private final String code;
    private final String message;

    ErrorCode(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
