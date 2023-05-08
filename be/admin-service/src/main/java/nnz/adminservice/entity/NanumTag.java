package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Entity
@Table(name = "nanum_tags")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Where(clause = "is_delete  = 0")
public class NanumTag extends BaseEntity {

    @Id
    private Long id;

    private String tag;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;
}
