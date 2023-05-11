package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Follower;
import nnz.nanumservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FollowerRepository extends JpaRepository<Follower, Long> {

    Optional<Follower> findByFollowingAndFollower(User provider, User follower);
}
