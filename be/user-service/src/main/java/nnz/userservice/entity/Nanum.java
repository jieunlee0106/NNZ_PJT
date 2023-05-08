package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "nanums")
@Where(clause = "is_delete = false")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
public class Nanum extends BaseEntity {

    @Id
    private Long id;

    private String title;
    private String thumbnail;
    private LocalDate date;
    private String location;
    private boolean isCertification;

    @Enumerated(value = EnumType.ORDINAL)
    private NanumStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "provider_id")
    private User provider;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    private Show show;

    @OneToMany(mappedBy = "nanum")
    private List<NanumTag> tags = new ArrayList<>();

    @Getter
    public enum NanumStatus {
        BEFORE(0), CLOSE(1), ONGOING(2), FINISH(3),
        ;

        private final int status;

        NanumStatus(int status) {
            this.status = status;
        }
    }
}
