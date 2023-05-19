package nnz.userservice.dto.sync;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.User;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class UserSyncDTO {

    private Long id;
    private String email;
    private String nickname;
    private String phone;
    private String profileImage;
    private String authProvider;
    private String deviceToken;
    private String role;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    private LocalDateTime createdAt;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    private LocalDateTime updatedAt;

    public static UserSyncDTO of(User user) {
        return UserSyncDTO.builder()
                .id(user.getId())
                .email(user.getEmail())
                .nickname(user.getNickname())
                .phone(user.getPhoneNumber())
                .profileImage(user.getProfileImage())
                .authProvider(user.getAuthProvider().name())
                .deviceToken(user.getDeviceToken())
                .role(user.getRole().name())
                .createdAt(user.getCreatedAt())
                .updatedAt(user.getUpdatedAt())
                .build();
    }
}
