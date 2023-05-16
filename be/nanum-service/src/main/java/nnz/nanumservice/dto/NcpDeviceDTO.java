package nnz.nanumservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NcpDeviceDTO {
    private String userId;
    private String deviceType;
    private String deviceToken;
    private Boolean isNotificationAgreement;
    private Boolean isAdAgreement;
    private Boolean isNightAdAgreement;
}
