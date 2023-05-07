package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "nanums")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
public class Nanum extends BaseEntity {

    @Id
    private Long id;

    private String title;
    private String thumbnail;

    @Enumerated(value = EnumType.ORDINAL)
    private NanumStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    private Show show;

    @OneToMany(mappedBy = "nanum")
    private List<NanumTag> tags = new ArrayList<>();

    @Getter
    public enum NanumStatus {
        BEFORE(0), ONGOING(1), CLOSE(2), FINISH(3),
        ;

        private final int status;

        NanumStatus(int status) {
            this.status = status;
        }
    }
}
