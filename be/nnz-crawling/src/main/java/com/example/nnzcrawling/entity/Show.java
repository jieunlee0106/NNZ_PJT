package com.example.nnzcrawling.entity;

import com.example.nnzcrawling.util.converter.ShowConverter;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "shows")
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Show extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Convert(converter = ShowConverter.class)
    private String location;

    @Convert(converter = ShowConverter.class)
    private String startDate;

    @Convert(converter = ShowConverter.class)
    private String endDate;

    @Convert(converter = ShowConverter.class)
    private String ageLimit;

    @Convert(converter = ShowConverter.class)
    private String region;

    @Convert(converter = ShowConverter.class)
    private String posterImage;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_code")
    private Category category;
}
