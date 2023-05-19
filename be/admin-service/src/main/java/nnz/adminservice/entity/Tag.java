package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Getter
@Entity
@Table(name = "tags")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Where(clause = "is_delete  = 0")
public class Tag extends BaseEntity {

    @Id
    private Long id;

    private String tag;

    // 조회수
    private Integer views;
}

