package nnz.userservice.service;

import io.github.eello.nnz.common.exception.CustomException;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.SignatureException;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.entity.User;
import nnz.userservice.exception.ErrorCode;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
public class JwtProvider {

    private final String secretKey;
    private final Long accessTokenExpirationPeriod;
    private final Long refreshTokenExpirationPeriod;

    public JwtProvider(
            @Value("${jwt.secret-key}") String secretKey,
            @Value("${jwt.expiration-period.access-token}") Long accessTokenExpirationPeriod,
            @Value("${jwt.expiration-period.access-token}") Long refreshTokenExpirationPeriod) {
        this.secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
        this.accessTokenExpirationPeriod = accessTokenExpirationPeriod;
        this.refreshTokenExpirationPeriod = refreshTokenExpirationPeriod;
    }

    public String generateAccessToken(User user) {
        return generateToken(user, accessTokenExpirationPeriod);
    }

    public String generateRefreshToken(User user) {
        return generateToken(user, refreshTokenExpirationPeriod);
    }

    private String generateToken(User user, Long expiration) {
        Date now = new Date();
        Date expirationPeriod = new Date(now.getTime() + expiration);

        Map<String, Object> claims = new HashMap<>();
        claims.put("id", user.getId());
        claims.put("email", user.getEmail());
        claims.put("role", user.getRole());
        claims.put("authProvider", user.getAuthProvider());

        return Jwts.builder()
                .setSubject(user.getId().toString())
                .setIssuer("nnz")
                .setIssuedAt(now)
                .addClaims(claims)
                .setExpiration(expirationPeriod)
                .signWith(SignatureAlgorithm.HS512, secretKey)
                .compact();
    }

    public Long getRefreshTokenExpirationPeriod() {
        return refreshTokenExpirationPeriod;
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token);
            return true;
        } catch (JwtException e) {
            return false;
        }
    }
}
