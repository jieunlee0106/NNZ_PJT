package nnz.userservice.repository;

import nnz.userservice.entity.Follow;
import nnz.userservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.Set;

public interface FollowRepository extends JpaRepository<Follow, Long> {

    boolean existsByFollowerAndFollowing(User me, User following);
    Optional<Follow> findByFollowerAndFollowing(User me, User following);
    Integer countByFollower(User follower); // 팔로잉 수 리턴
    Integer countByFollowing(User following); // 팔로워 수 리턴

    @Query("select f.follower from Follow f " +
            "where f.following = :user")
    Set<User> findFollower(@Param("user") User user); // user의 팔로워 조회
}
