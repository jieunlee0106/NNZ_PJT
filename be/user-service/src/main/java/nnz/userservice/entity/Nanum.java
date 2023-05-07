package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

import javax.persistence.*;

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

    public enum NanumStatus {
        BEFORE(0), ONGOING(1), CLOSE(2), FINISH(3),
        ;

        private final int status;

        NanumStatus(int status) {
            this.status = status;
        }
    }
}
