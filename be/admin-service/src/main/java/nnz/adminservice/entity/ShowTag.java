package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Entity
@Table(name = "show_tags")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Where(clause = "is_delete  = 0")
public class ShowTag extends BaseEntity {

    @Id
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    Show show;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id")
    Tag tag;
}

