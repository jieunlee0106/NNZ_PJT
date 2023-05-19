package nnz.userservice.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class SmsResponseDTO {

    private String requestId;
    private LocalDateTime requestTime;
    private String statusCode;
    private String statusName;
}
