package nnz.adminservice.exception;

import io.github.eello.nnz.common.exception.AbstractErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.NOT_FOUND;

@RequiredArgsConstructor
public enum ErrorCode implements AbstractErrorCode {

    USER_NOT_FOUND("U009", "등록되지 않은 사용자입니다.", NOT_FOUND),
    ASKED_SHOW_NOT_FOUND("AS001", "등록되지 않은 공연 요청입니다.", NOT_FOUND),
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
