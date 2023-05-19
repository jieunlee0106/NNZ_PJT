package nnz.userservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.redis.core.RedisHash;

import javax.persistence.Id;

@RedisHash(value = "refresh")
@Getter
@AllArgsConstructor
@Builder
@ToString
public class RefreshToken {

    @Id
    private String id;

    private String refreshToken;
}
