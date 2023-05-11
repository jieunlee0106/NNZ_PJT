package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "nanums")
@Where(clause = "is_delete = false")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@ToString(of = {"id", "title", "status"})
public class Nanum {

    @Id
    private Long id;

    private String title;
    private String thumbnail;
    private LocalDate date;
    private String location;
    private boolean isCertification;
    private LocalDateTime updatedAt;
    private boolean isDelete;

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

    public Nanum updateTitle(String title) {
        this.title = title;
        return this;
    }

    public Nanum updateThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
        return this;
    }

    public Nanum updateStatus(NanumStatus status) {
        this.status = status;
        return this;
    }

    public Nanum updateLocation(String location) {
        this.location = location;
        return this;
    }

    public Nanum updateDate(LocalDate date) {
        this.date = date;
        return this;
    }

    public Nanum updateIsCertification(boolean isCertification) {
        this.isCertification = isCertification;
        return this;
    }

    public void update(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    };

    @Getter
    @RequiredArgsConstructor
    public enum NanumStatus {
        BEFORE(0), CLOSE(1), ONGOING(2), FINISH(3),
        ;

        private final int status;

        public static NanumStatus valueOf(int status) {
            for (NanumStatus value : NanumStatus.values()) {
                if (value.getStatus() == status) {
                    return value;
                }
            }
            return null;
        }
    }
}
