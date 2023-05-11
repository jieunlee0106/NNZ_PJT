package nnz.gatewayservice.filter;

import com.google.gson.Gson;
import io.jsonwebtoken.*;
import nnz.gatewayservice.dto.ErrorResponse;
import nnz.gatewayservice.error.ErrorCode;
import nnz.gatewayservice.jwt.JwtValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Objects;

@Component
public class JwtFilter extends AbstractGatewayFilterFactory<JwtFilter.Config> {

    private static final String AUTHORIZATION_ATTR = "Authorization";

    private final Logger log = LoggerFactory.getLogger(this.getClass());
    private final JwtValidator jwtValidator;

    JwtFilter(JwtValidator jwtValidator) {
        super(Config.class);
        this.jwtValidator = jwtValidator;
    }

    @Override
    public GatewayFilter apply(Config config) {
        return (((exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();
            HttpMethod method = request.getMethod();
            String requestPath = request.getPath().toString();

            // 인증이 필요없는 API는 통과
            if (isPermit(method, requestPath)) {
                return chain.filter(exchange);
            }

            // 헤더에 Authorization 속성이 존재하는지 검증
            if (!request.getHeaders().containsKey(AUTHORIZATION_ATTR)) {
                return handleUnauthorized(exchange, ErrorCode.NO_AUTHORIZATION_ATTR);
            }

            // Request Header 에서 Jwt 문자열 받아오기
            List<String> authorizationHeader = request.getHeaders().get(AUTHORIZATION_ATTR);
            String authorization = Objects.requireNonNull(authorizationHeader).get(0);

            if (!authorization.startsWith("Bearer ")) { // 토큰이 Bearer 토큰인지 검증
                return handleUnauthorized(exchange, ErrorCode.UNSUPPORTED_JWT);
            }

            String jwt = authorization.substring(7);

            // 토큰 스트링이 존재하는지 검증
            if (!StringUtils.hasText(jwt)) {
                return handleUnauthorized(exchange, ErrorCode.EMPTY_JWT);
            }

            Claims claims;

            try {
                claims = jwtValidator.validateToken(jwt);
            } catch (SignatureException | MalformedJwtException e) {
                return handleUnauthorized(exchange, ErrorCode.MALFORMED_JWT);
            } catch (ExpiredJwtException e) {
                return handleUnauthorized(exchange, ErrorCode.EXPIRED_JWT);
            } catch (UnsupportedJwtException e) {
                return handleUnauthorized(exchange, ErrorCode.UNSUPPORTED_JWT);
            } catch (JwtException e) {
                return handleUnauthorized(exchange, ErrorCode.INVALID_JWT);
            }

            String role = claims.get("role", String.class);

            // 일반 사용자가 관리자 API에 접근하는 경우
            if (requestPath.startsWith(PermilAllUrlList.ADMIN_SERVICE) && !"ADMIN".equals(role)) {
                return handleForbidden(exchange, ErrorCode.FORBIDDEN);
            }

            return chain.filter(exchange);
        }));
    }

    // 401 에러 핸들러
    private Mono<Void> handleUnauthorized(ServerWebExchange exchange, ErrorCode errorCode) {
        log.info("unauthorized: {}", errorCode.getMessage());
        return writeMessage(exchange, errorCode, HttpStatus.UNAUTHORIZED);
    }

    // 403 에러 핸들러
    private Mono<Void> handleForbidden(ServerWebExchange exchange, ErrorCode errorCode) {
        log.info("forbidden: {}", errorCode.getMessage());
        return writeMessage(exchange, errorCode, HttpStatus.FORBIDDEN);
    }

    // 응답에 ErrorResponse 작성
    private Mono<Void> writeMessage(ServerWebExchange exchange, ErrorCode errorCode, HttpStatus httpStatus) {
        String requestUrl = exchange.getRequest().getPath().toString();

        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);

        Gson gson = new Gson();
        byte[] bytes = gson.toJson(ErrorResponse.of(errorCode, requestUrl))
                .getBytes(StandardCharsets.UTF_8);
        DataBuffer buffer = response.bufferFactory().wrap(bytes);
        return response.writeWith(Flux.just(buffer));
    }

    /**
     * HTTP METHOD에 따라 인증이 필요 없는 서비스인지 확인하는 메소드
     * 인증이 없는 서비스 -> return true;
     */
    private boolean isPermit(HttpMethod httpMethod, String url) {
        String[] permitAllUrls = PermilAllUrlList.findPermitAllUrl(httpMethod);

        // 해당 메소드에 인증이 필요없는 서비스가 없으면
        if (permitAllUrls == null) {
            return false;
        }

        for (String permitAllUrl : permitAllUrls) {
            if (permitAllUrl.equals(url)) {
                return true;
            }
        }
        return false;
    }

    public static class Config {
        private String baseMessage;
        private boolean preLogger;
        private boolean postLogger;
    }
}
