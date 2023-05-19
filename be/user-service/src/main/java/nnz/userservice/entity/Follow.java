package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "follows")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
public class Follow extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "follower_id", nullable = false)
    private User follower; // 나를 기준으로 나를 구독한 사람

    @ManyToOne
    @JoinColumn(name = "following_id", nullable = false)
    private User following; // 나를 기준으로 내가 구독한 사람

    public void reFollow() {
        this.isDelete = false;
    }
    public void unfollow() {
        this.isDelete = true;
    }
}
