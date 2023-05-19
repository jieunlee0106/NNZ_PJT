package nnz.userservice.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.*;
import nnz.userservice.entity.User;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class UserDTO {

    private Long id;
    private String email;
    private String nickname;
    private String phone;
    private String profileImage;
    private User.AuthProvider authProvider;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Integer followerCount;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Integer followingCount;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Statistics statistics;


    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime lastLoginAt;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    public static UserDTO of(User user) {
        UserDTO dto = new UserDTO();
        dto.id = user.getId();
        dto.email = user.getEmail();
        dto.nickname = user.getNickname();
        dto.phone = user.getPhoneNumber();
        dto.profileImage = user.getProfileImage();
        dto.authProvider = user.getAuthProvider();
        dto.lastLoginAt = user.getLastLoginAt();
        dto.updatedAt = user.getUpdatedAt();
        return dto;
    }

    public void setFollowerCount(Integer followerCount) {
        this.followerCount = followerCount;
    }

    public void setFollowingCount(Integer followingCount) {
        this.followingCount = followingCount;
    }

    public void setStatistics(Statistics statistics) {
        this.statistics = statistics;
    }

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Statistics {
        StatisticsDTO nanum;
        StatisticsDTO receive;
    }
}
