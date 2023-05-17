package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.dto.ShowDTO;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "shows")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Where(clause = "is_delete  = 0")
public class Show extends BaseEntity {

    @Id
    private Long id;

    private String title;
    private String location;
    private String startDate;
    private String endDate;
    private String ageLimit;
    private String region;
    private String posterImage;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_code")
    private Category category;
}

