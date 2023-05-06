package nnz.adminservice.dto;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class ReportDTO {

    private LocalDateTime reportedAt;
    private Long reportedId;
    private Long targetId;
    private String reason;
    private int status;
}
