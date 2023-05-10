package nnz.gatewayservice.error;

public enum ErrorCode {

    MALFORMED_JWT("AUTH001", "유효하지 않은 토큰입니다."),
    EXPIRED_JWT("AUTH002", "만료된 토큰입니다."),
    UNSUPPORTED_JWT("AUTH003", "지원되지 않는 토큰입니다."),
    INVALID_JWT("AUTH004", "잘못된 토큰입니다."),

    FORBIDDEN("AUTH005", "접근 권한이 없습니다."),
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
