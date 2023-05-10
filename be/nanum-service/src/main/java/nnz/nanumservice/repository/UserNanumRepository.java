package nnz.nanumservice.repository;

import nnz.nanumservice.entity.UserNanum;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserNanumRepository extends JpaRepository<UserNanum, Long> {
}
