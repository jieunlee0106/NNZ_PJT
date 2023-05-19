package nnz.nanumservice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.rpc.LocalizedMessage;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NcpMessageDTO {
    private String messageType;
    private Boolean isNotificationAgreement;
    private Boolean isAdAgreement;
    private Boolean isNightAdAgreement;
    private Target target;
    private Message message;

    private String reserveTime;
    private String reserveTimeZone;
    private String scheduleCode;

    @Getter
    @Builder
    public static class Target{
        private String type;
        private String deviceType;
        private List<String> to;
        private List<String> country;
    }

    @Getter
    @Builder
    public static class Message{
        @JsonProperty("default")
        private DefaultMessage defaultMessage;
        private DefaultMessage gcm;
        private DefaultMessage apns;
    }

    @Getter
    @Builder
    public static class DefaultMessage {
        private String content;
        private Map<String, String> custom;
        private Map<String, LocalizedMessage> i18n;
    }
}
