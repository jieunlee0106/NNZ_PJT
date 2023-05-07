package nnz.userservice.service;

import nnz.userservice.entity.User;

public interface FollowService {

    void follow(Long meId, Long followingId);
    void unfollow(Long meId, Long followingId);
    boolean isFollow(User me, User following);
}
