package nnz.nanumservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Table(name = "user_nanums")
@Getter
@Builder
@AllArgsConstructor
@SQLDelete(sql = "UPDATE UserNanum SET is_delete = 1 WHERE id = ?")
@Where(clause = "is_delete  = 0")
public class UserNanum extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Boolean isCertificated;
    private Boolean isReceived;

    //todo: user -> receiver 변수명 바꿈 유리한테 알려줄것
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User receiver;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    public void updateIsCertificated(Boolean cert){
        this.isCertificated = cert;
    }
}
