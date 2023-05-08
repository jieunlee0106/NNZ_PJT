package nnz.tagservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "nanums")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Nanum {

    @Id
    private Long id;

    private String title;
}
