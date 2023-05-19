package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

@Entity
@Table(name = "nanum_tags")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DynamicUpdate
@AllArgsConstructor
@Builder
@Getter
public class NanumTag {

    @Id
    private Long id;

    private String tag;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    private boolean is_delete;
}
