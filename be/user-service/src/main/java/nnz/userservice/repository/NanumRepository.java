package nnz.userservice.repository;

import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NanumRepository extends JpaRepository<Nanum, Long> {

    List<Nanum> findByProvider(User user);
}
