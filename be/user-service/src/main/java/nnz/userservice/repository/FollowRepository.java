package nnz.userservice.repository;

import nnz.userservice.entity.Follow;
import nnz.userservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FollowRepository extends JpaRepository<Follow, Long> {

    boolean existsByFollowerAndFollowing(User me, User following);
    Optional<Follow> findByFollowerAndFollowing(User me, User following);
    Integer countByFollower(User follower); // 팔로잉 수 리턴
    Integer countByFollowing(User following); // 팔로워 수 리턴
}
