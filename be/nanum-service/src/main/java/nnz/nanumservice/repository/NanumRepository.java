package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.Show;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NanumRepository extends JpaRepository<Nanum, Long> {

    Page<Nanum> findByShowAndIsDeleteFalse(Show show, Pageable pageRequest);
}
