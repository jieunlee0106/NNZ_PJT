package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

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
public class User extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
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
}