package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Entity
@NoArgsConstructor
@Table(name = "reports")
@Getter
public class Report extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reporter_id")
    private User reporter;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "target_id")
    private User target;
    private String reason;
    private ReportStatus status;
    private LocalDateTime reportedAt;
    private LocalDateTime processedAt;

    @Getter
    @RequiredArgsConstructor
    public enum ReportStatus {
        WAIT(0),
        ACCEPT(1),
        REFUSE(2);

        private final int code;

        private static final Map<Integer, String> CODE_MAP = Collections.unmodifiableMap(
                Stream.of(values()).collect(Collectors.toMap(ReportStatus::getCode, ReportStatus::name))
        );

        public static ReportStatus of(final int code){
            return ReportStatus.valueOf(CODE_MAP.get(code));
        }
    }

    public void updateStatus(int code){
        this.status = ReportStatus.of(code);
    }
}
