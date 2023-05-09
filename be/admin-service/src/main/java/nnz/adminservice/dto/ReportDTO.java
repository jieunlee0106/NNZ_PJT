package nnz.adminservice.dto;

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

    private LocalDateTime reportedAt;
    private Long reportedId;
    private Long targetId;
    private String reason;
    private int status;
}
