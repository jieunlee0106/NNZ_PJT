package nnz.adminservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.*;
import nnz.adminservice.entity.User;

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
}
