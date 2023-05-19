package nnz.userservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

import javax.persistence.Id;

@RedisHash(value = "iat")
@Getter
@AllArgsConstructor
@Builder
@ToString
public class AccessTokenBlacklist {

    @Id
    private String id; // = accessToken

    @TimeToLive
    private Long ttl;
}
