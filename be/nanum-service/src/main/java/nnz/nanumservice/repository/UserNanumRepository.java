package nnz.nanumservice.repository;

import nnz.nanumservice.entity.User;
import nnz.nanumservice.entity.UserNanum;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserNanumRepository extends JpaRepository<UserNanum, Long> {

    Optional<UserNanum> findByReceiver(User receiver);
}
