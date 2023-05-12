package nnz.nanumservice.dto;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class FCMNotificationDTO {
    private String userToken;
    private String title;
    private String body;
    private LocalDateTime eventTime;
}
