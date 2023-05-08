package nnz.tagservice.repository;

import nnz.tagservice.entity.Nanum;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface NanumRepository extends JpaRepository<Nanum, Long> {

    List<Nanum> findByTitleContaining(String title);
}
