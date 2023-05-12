package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "nanum_images")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class NanumImage extends BaseEntity {

    @Id
    private Long id;

    private String path;

    private String originalName;

    private Boolean isThumbnail;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

}
