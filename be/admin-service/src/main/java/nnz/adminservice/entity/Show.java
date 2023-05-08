package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "shows")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Show extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

