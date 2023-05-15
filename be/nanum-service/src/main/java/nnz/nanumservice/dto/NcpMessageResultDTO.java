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
public class NcpMessageResultDTO {
    private String requestId;
    private String requestTime;
    private String statusCode;
    private String statusName;
    private String messageStatusCode;
    private String messageStatusName;
    private String completeTime;
    private Integer targetCount;
    private Integer sentCount;
    private String messageType;
    private List<Object> target;
    private List<Object> message;
}
