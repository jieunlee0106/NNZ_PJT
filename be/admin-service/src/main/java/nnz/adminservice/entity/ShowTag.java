package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "show_tags")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShowTag extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    Show show;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id")
    Tag tag;
}

