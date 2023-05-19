package nnz.gatewayservice.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Base64;

@Component
public class JwtValidator {

    private final String secretKey;
    private final AccessTokenBlacklistRepository blacklist;

    public JwtValidator(
            @Value("${jwt.secret-key}") String secretKey,
            AccessTokenBlacklistRepository blacklist) {
        this.secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
        this.blacklist = blacklist;
    }

    public Claims validateToken(String token) {
        // 로그아웃된 토큰으로 요청시
        if (blacklist.findById(token).isPresent()) {
            throw new JwtException("유효하지 않은 토큰입니다.");
        }

        Jws<Claims> claims = Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token);
        return claims.getBody();
    }
}
