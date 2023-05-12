package nnz.nanumservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.UserDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class User {

    @Id
    private Long id;

    private String email;

    private String nickname;

    private String profileImage;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static User of(UserDTO userDTO) {
        return User.builder()
                .id(userDTO.getId())
                .email(userDTO.getEmail())
                .nickname(userDTO.getNickname())
                .profileImage(userDTO.getProfileImage())
                .updatedAt(userDTO.getUpdatedAt())
                .isDelete(false)
                .build();
    }

    public void updateUser(UserDTO userDTO) {
        this.id = userDTO.getId();
        this.nickname = userDTO.getNickname();
        this.profileImage = userDTO.getProfileImage();
        this.updatedAt = userDTO.getUpdatedAt();
    }

    public void deleteUser() {
        this.isDelete = true;
    }
}
