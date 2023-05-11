package nnz.nanumservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.redis.core.RedisHash;

import org.springframework.data.annotation.Id;

import java.io.Serializable;

@RedisHash(value = "ns", timeToLive = 60 * 60 * 12) // keyspace: ns, expire: 12hours
@Getter
@AllArgsConstructor
@Builder
@ToString
public class NanumStock implements Serializable {

    @Id
    private Long id;

    private Integer stock;

    public void minusStock(){
        this.stock -= 1;
    }
}
