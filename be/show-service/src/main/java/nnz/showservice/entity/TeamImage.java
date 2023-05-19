package nnz.showservice.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "team_images")
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class TeamImage {

    @Id
    private String name;

    private String image;
}
