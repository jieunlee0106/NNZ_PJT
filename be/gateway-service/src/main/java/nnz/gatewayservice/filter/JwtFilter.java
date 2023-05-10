package nnz.gatewayservice.filter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.google.gson.Gson;
import io.jsonwebtoken.*;
import nnz.gatewayservice.dto.ErrorResponse;
import nnz.gatewayservice.error.ErrorCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Objects;

//@Slf4j
@Component
public class JwtFilter extends AbstractGatewayFilterFactory<JwtFilter.Config> {

    private static final String AUTHORIZATION_ATTR = "Authorization";
    private static final ObjectWriter jsonWriter = new ObjectMapper().writer();

    private final Logger log = LoggerFactory.getLogger(this.getClass());
    private final JwtValidator jwtValidator;

    JwtFilter(JwtValidator jwtValidator) {
        super(Config.class);
        this.jwtValidator = jwtValidator;
    }

    @Override
    public GatewayFilter apply(Config config) {
        return (((exchange, chain) -> {
            log.info("jwt filtering");
            ServerHttpRequest request = exchange.getRequest();
            HttpMethod method = request.getMethod();
            String requestPath = request.getPath().toString();

            if (isPermit(method, requestPath)) {
                return chain.filter(exchange);
            }

            if (!request.getHeaders().containsKey(AUTHORIZATION_ATTR)) {
                return handleUnauthorized(exchange, "헤더에 " + AUTHORIZATION_ATTR + " 속성이 존재하지 않습니다.");
            }

            // Request Header 에서 token 문자열 받아오기
            List<String> authorizationHeader = request.getHeaders().get(AUTHORIZATION_ATTR);
            String authorization = Objects.requireNonNull(authorizationHeader).get(0);

            if (!authorization.startsWith("Bearer ")) { // 토큰이 Bearer 토큰인지 검증
                return handleUnauthorized(exchange, ErrorCode.UNSUPPORTED_JWT);
            }

            String jwt = authorization.substring(7);
            Claims claims;

            try {
                claims = jwtValidator.validateToken(jwt);
            } catch (SignatureException | MalformedJwtException e) {
                return handleUnauthorized(exchange, ErrorCode.MALFORMED_JWT);
            }catch (ExpiredJwtException e) {
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

    private Mono<Void> handleUnauthorized(ServerWebExchange exchange, ErrorCode errorCode) {
        log.info("unauthorized: {}", errorCode.getMessage());
        return writeMessage(exchange, errorCode);
    }

    private Mono<Void> handleForbidden(ServerWebExchange exchange, ErrorCode errorCode) {
        log.info("forbidden: {}", errorCode.getMessage());
        return writeMessage(exchange, errorCode);
    }

    private Mono<Void> writeMessage(ServerWebExchange exchange, ErrorCode errorCode) {
        String requestUrl = exchange.getRequest().getPath().toString();

        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(HttpStatus.UNAUTHORIZED);

        Gson gson = new Gson();
//        byte[] bytes = jsonWriter.writeValueAsBytes(ErrorResponse.of(errorCode, requestUrl));
        byte[] bytes = gson.toJson(ErrorResponse.of(errorCode, requestUrl)).getBytes(StandardCharsets.UTF_8);
        DataBuffer buffer = response.bufferFactory().wrap(bytes);
        return response.writeWith(Flux.just(buffer));
    }

    private boolean isPermit(HttpMethod httpMethod, String url) {
        String[] permitAllUrls = PermilAllUrlList.findPermitAllUrl(httpMethod);

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
