package nnz.userservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

import java.time.LocalDateTime;

@RedisHash(value = "vn", timeToLive = 60 * 30) // keyspace: vn, expire: 30min
@Getter
@AllArgsConstructor
@Builder
@ToString
public class VerifyNumber {

    @Id
    private String phone;
    private Integer verifyNumber;
    private boolean isVerify;
    private LocalDateTime expirationDateTime;

    public void verify(int verifyNumber) {
        // 인증번호가 만료되지 않았으며 인증번호가 일치하면
        System.out.println(LocalDateTime.now().isBefore(this.expirationDateTime ));
        if (LocalDateTime.now().isBefore(this.expirationDateTime) && this.verifyNumber == verifyNumber) {
            this.isVerify = true;
        }
    }
}


