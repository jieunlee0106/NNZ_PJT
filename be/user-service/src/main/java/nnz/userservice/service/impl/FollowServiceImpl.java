package nnz.userservice.service.impl;

import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.entity.Follow;
import nnz.userservice.entity.User;
import nnz.userservice.exception.ErrorCode;
import nnz.userservice.repository.FollowRepository;
import nnz.userservice.repository.UserRepository;
import nnz.userservice.service.FollowService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class FollowServiceImpl implements FollowService {

    private final UserRepository userRepository;
    private final FollowRepository followRepository;

    @Override
    @Transactional
    public void follow(Long meId, Long followingId) {
        User me = userRepository.findById(meId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        // 내가 구독할 사용자
        User following = userRepository.findById(followingId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        Follow follow = followRepository.findByFollowerAndFollowing(me, following).orElse(null);
        if (follow != null) { // 팔로우 한 이력이 있다면
            if (follow.getIsDelete()) follow.reFollow(); // 재팔로우
            else throw new CustomException(ErrorCode.ALREADY_FOLLOWING); // 이미 팔로우 중인 경우
        } else { // 새로운 팔로우 등록
            follow = Follow.builder()
                    .follower(me)
                    .following(following)
                    .build();

            followRepository.save(follow);
        }

        log.info("{}님이 {}님을 팔로우", me.getEmail(), following.getEmail());
    }

    /**
     * 내가 대상을 팔로우하고 있는지 여부
     */
    @Override
    public boolean isFollow(User me, User following) {
        return followRepository.existsByFollowerAndFollowing(me, following);
    }
}
