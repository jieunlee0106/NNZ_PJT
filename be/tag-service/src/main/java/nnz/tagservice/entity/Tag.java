package nnz.tagservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

@Entity
@Table(name = "tags")
@NoArgsConstructor
@DynamicUpdate
@AllArgsConstructor
@Builder
@Getter
public class Tag extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String tag;

    @Builder.Default
    private Integer views = 0;

    public void updateViews(int views) {
        this.views = views;
    }
}
