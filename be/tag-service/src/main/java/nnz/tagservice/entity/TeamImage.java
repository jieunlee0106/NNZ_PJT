package com.example.nnzcrawling.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import org.hibernate.annotations.Where;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "team_images")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Where(clause = "is_delete = 0")
public class TeamImage extends BaseEntity {

    @Id
    private String name;

    private String image;
}
