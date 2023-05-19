package nnz.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class OtherUserInfoDTO {

    private Long id;
    private String nickname;
    private String profileImage;
    private Boolean isFollow;
    private Boolean isTwitterFollow;
    private Integer followerCount;
    private Integer followingCount;
    private Statistics statistics;


    @AllArgsConstructor
    @Builder
    @Getter
    public static class Statistics {
        private Integer totalCount;
        private Integer nanumCount;
        private Integer receiveCount;
    }
}
