package nnz.nanumservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.FollowerSyncDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "followers")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Follower {

    @Id
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "follower_id")
    private User follower;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "following_id")
    private User following;

    private boolean isDelete;
    private LocalDateTime updatedAt;

    public void update(FollowerSyncDTO dto, User follower, User following) {
        this.follower = follower;
        this.following = following;
        this.isDelete = dto.getIsDelete();
        this.updatedAt = dto.getUpdatedAt();
    }

    public void delete() {
        this.isDelete = true;
    }
}
