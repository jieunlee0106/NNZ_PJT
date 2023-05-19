package nnz.nanumservice.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FcmNotificationDTO {
    private String userToken;
    private String title;
    private String body;
}
