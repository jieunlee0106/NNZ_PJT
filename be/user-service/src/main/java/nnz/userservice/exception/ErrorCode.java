package nnz.userservice.exception;

import io.github.eello.nnz.common.exception.AbstractErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@RequiredArgsConstructor
public enum ErrorCode implements AbstractErrorCode {

    DUPLICATE_EMAIL("U001", "이미 등록된 이메일입니다.", CONFLICT),
    DUPLICATE_NICKNAME("U002", "이미 등록된 닉네임입니다.", CONFLICT),
    INVALID_NICKNAME_PATTERN("U003", "올바르지 않은 닉네임 형식입니다.", BAD_REQUEST),
    INVALID_PWD_PATTERN("U004", "올바르지 않은 비밀번호 형식입니다.", BAD_REQUEST),
    INVALID_EMAIL_PATTERN("U005", "올바르지 이메일 형식입니다.", BAD_REQUEST),
    NOT_FOUND_VERIFY("U006", "존재하지 않는 인증정보입니다.", NOT_FOUND),
    NOT_VERIFIED("U007", "본인확인이 되지 않았습니다.", BAD_REQUEST),
    PWD_NOT_MATCH_CONFIRM_PWD("U008", "비밀번호와 비밀번호 확인이 일치하지 않습니다.", BAD_REQUEST),
    ;

    private final String code;
    private final String message;
    private final HttpStatus status;

    @Override
    public String getCode() {
        return this.code;
    }

    @Override
    public String getMessage() {
        return this.message;
    }

    @Override
    public HttpStatus getStatus() {
        return this.status;
    }
}
