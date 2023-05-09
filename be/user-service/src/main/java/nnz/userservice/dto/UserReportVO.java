package nnz.userservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@Builder
@NoArgsConstructor
@Getter
@ToString
public class UserReportVO {

    private Long reporterId;
    private Long targetId;
    private String reason;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    private LocalDateTime reportedAt = LocalDateTime.now();

    public void setReporterId(Long reporterId) {
        this.reporterId = reporterId;
    }
}
