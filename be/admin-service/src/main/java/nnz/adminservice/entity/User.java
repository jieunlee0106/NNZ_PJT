package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import nnz.adminservice.dto.UserDTO;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users", uniqueConstraints = {
        @UniqueConstraint(name = "EMAIL_UNIQUE", columnNames = "email"),
        @UniqueConstraint(name = "NICKNAME_UNIQUE", columnNames = "nickname")
})
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@ToString
@SQLDelete(sql = "UPDATE User SET is_delete = 1 WHERE id = ?")
@Where(clause = "is_delete  = 0")
public class User extends BaseEntity {

    @Id
    private Long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = true)
    private String password;

    @Column(nullable = false, length = 16)
    private String nickname;

    @Column(nullable = false)
    private String phoneNumber; // '-'을 뺀 형식 ex)01012345678
    private String profileImage; // 프로필 이미지 경로

    @Enumerated(value = EnumType.STRING)
    private AuthProvider authProvider;

    @Enumerated(value = EnumType.STRING)
    private Role role;

    private LocalDateTime lastLoginAt;

    public enum Role {
        USER, ADMIN,
        ;
    }

    public enum AuthProvider {
        NNZ, TWITTER,
        ;
    }

    public static User of(UserDTO userDTO){
        User user = new User();
        user.id = userDTO.getId();
        user.email = userDTO.getEmail();
        user.nickname = userDTO.getNickname();
        user.phoneNumber = userDTO.getPhone();
        user.profileImage = userDTO.getProfileImage();
        user.authProvider = AuthProvider.valueOf(userDTO.getAuthProvider());
        user.role = Role.valueOf(userDTO.getRole());
        return user;
    }
}