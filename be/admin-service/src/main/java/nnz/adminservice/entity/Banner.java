package nnz.adminservice.entity;

import lombok.*;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
@Table(name = "banners")
@SQLDelete(sql = "UPDATE Banner SET is_delete = 1 WHERE id = ?")
@Where(clause = "is_delete  = 0")
public class Banner {

    @Id
    private Long id;

    private String image;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    private Show show;
}
