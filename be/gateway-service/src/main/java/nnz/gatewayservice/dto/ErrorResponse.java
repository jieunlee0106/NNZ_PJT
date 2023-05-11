package nnz.gatewayservice.dto;

import nnz.gatewayservice.error.ErrorCode;

public class ErrorResponse {

    private String code;
    private String message;
    private String requestUrl;

    public ErrorResponse() {}

    public ErrorResponse(String code, String message, String requestUrl) {
        this.code = code;
        this.message = message;
        this.requestUrl = requestUrl;
    }

    public static ErrorResponse of(ErrorCode errorCode, String requestUrl) {
        ErrorResponse response = new ErrorResponse();
        response.code = errorCode.getCode();
        response.message = errorCode.getMessage();
        response.requestUrl = requestUrl;
        return response;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getRequestUrl() {
        return requestUrl;
    }

    public void setRequestUrl(String requestUrl) {
        this.requestUrl = requestUrl;
    }
}
