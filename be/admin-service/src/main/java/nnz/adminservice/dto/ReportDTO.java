package nnz.adminservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReportDTO {
    private Long id;
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime reportedAt;
    private Long reporterId;
    private Long targetId;
    private String reason;
    private int status;
}
