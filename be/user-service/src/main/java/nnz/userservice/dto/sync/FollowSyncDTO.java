package nnz.userservice.dto.sync;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.*;
import nnz.userservice.entity.Follow;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@ToString
public class FollowSyncDTO {

    private Long id;
    private Long followerId;
    private Long followingId;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    private LocalDateTime createdAt;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    private LocalDateTime updatedAt;

    private Boolean isDelete;

    public static FollowSyncDTO of(Follow follow) {
        return FollowSyncDTO.builder()
                .id(follow.getId())
                .followerId(follow.getFollower().getId())
                .followingId(follow.getFollowing().getId())
                .updatedAt(follow.getUpdatedAt())
                .isDelete(follow.getIsDelete())
                .build();
    }
}
