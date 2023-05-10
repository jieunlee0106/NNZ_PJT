package nnz.gatewayservice.filter;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Base64;

@Component
public class JwtValidator {

    private final String secretKey;

    public JwtValidator(@Value("${jwt.secret-key}") String secretKey) {
        this.secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    public Claims validateToken(String token) {
        Jws<Claims> claims = Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token);
        return claims.getBody();
    }
}
