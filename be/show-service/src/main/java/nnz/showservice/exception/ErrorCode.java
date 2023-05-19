package nnz.showservice.exception;

import io.github.eello.nnz.common.exception.AbstractErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@RequiredArgsConstructor
public enum ErrorCode implements AbstractErrorCode {

    SHOW_NOT_FOUND("S001", "등록되지 않은 공연입니다.", NOT_FOUND),
    CATEGORY_NOT_FOUND("C001", "등록되지 않은 카테고리입니다.", NOT_FOUND),
    NANUM_NOT_FOUND("N001", "등록되지 않은 나눔입니다.", NOT_FOUND),
    TAG_NOT_FOUND("T001", "등록되지 않은 태그입니다.", NOT_FOUND),
    JSON_PROCESSING_EXCEPTION("ETC001", "ObjectMapper : Object -> JSON String 변환 에러.", INTERNAL_SERVER_ERROR),
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
