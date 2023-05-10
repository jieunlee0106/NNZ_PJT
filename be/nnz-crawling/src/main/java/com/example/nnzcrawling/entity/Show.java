package com.example.nnzcrawling.entity;

import com.example.nnzcrawling.dto.ShowDTO;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "shows")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
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

    public static Show of(ShowCrawling v, Category category) {
        return Show.builder()
                .title(v.getTitle())
                .location(v.getLocation())
                .startDate(v.getStartDate())
                .endDate(v.getEndDate())
                .ageLimit(v.getAgeLimit())
                .region(v.getRegion())
                .posterImage(v.getPosterImage())
                .category(category)
                .build();
    }

    public static Show dtoToEntity(ShowDTO showDTO, Category category) {
        return Show.builder()
                .title(showDTO.getTitle())
                .location(showDTO.getLocation())
                .startDate(showDTO.getStartDate())
                .endDate(showDTO.getEndDate())
                .ageLimit(showDTO.getAgeLimit())
                .region(showDTO.getRegion())
                .posterImage(showDTO.getPosterImage())
                .category(category)
                .build();
    }
}
