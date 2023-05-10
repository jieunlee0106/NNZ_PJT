package nnz.gatewayservice.filter;

import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Encoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.security.Key;
import java.util.Base64;

@Component
public class JwtValidator {

    private final String secretKey;

    public JwtValidator(@Value("${jwt.secret-key}") String secretKey) {
//        Key key = Keys.secretKeyFor(SignatureAlgorithm.HS512);
//        this.secretKey = Encoders.BASE64.encode(key.getEncoded());
        this.secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    public Claims validateToken(String token) {
        Jws<Claims> claims = Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token);
        return claims.getBody();
    }
}
