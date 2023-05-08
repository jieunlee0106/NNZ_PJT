package nnz.tagservice.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "shows")
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Show {

    @Id
    private Long id;

    private String title;
}
