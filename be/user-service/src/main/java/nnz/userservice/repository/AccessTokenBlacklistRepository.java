package nnz.userservice.repository;

import nnz.userservice.entity.AccessTokenBlacklist;
import org.springframework.data.repository.CrudRepository;

public interface AccessTokenBlacklistRepository extends CrudRepository<AccessTokenBlacklist, String> {
}
