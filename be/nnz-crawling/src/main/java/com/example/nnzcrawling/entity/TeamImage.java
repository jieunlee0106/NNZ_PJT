package com.example.nnzcrawling.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "team_images")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TeamImage extends BaseEntity {

    @Id
    private String name;

    private String image;
}
