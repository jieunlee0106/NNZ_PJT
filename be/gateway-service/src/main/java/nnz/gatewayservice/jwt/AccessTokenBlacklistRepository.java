package nnz.gatewayservice.jwt;

import org.springframework.data.repository.CrudRepository;

public interface AccessTokenBlacklistRepository extends CrudRepository<AccessTokenBlacklist, String> {
}
