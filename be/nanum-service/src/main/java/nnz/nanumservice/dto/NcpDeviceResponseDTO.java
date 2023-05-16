package nnz.nanumservice.dto;

import com.google.api.client.util.DateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NcpDeviceResponseDTO {
    private String userId;
    private String country;
    private String language;
    private Integer timezone;
    private Boolean notificationAgreement;
    private Boolean adAgreement;
    private Boolean nightAdAgreement;
    private DateTime notificationAgreementTime;
    private DateTime adAgreementTime;
    private DateTime nightAdAgreementTime;
    private DateTime createTime;
    private DateTime updateTime;
    private List<Device> devices;


    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Device{
        private String deviceType;
        private String deviceToken;
    }
}
