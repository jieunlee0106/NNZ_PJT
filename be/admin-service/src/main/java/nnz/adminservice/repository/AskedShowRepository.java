package nnz.adminservice.repository;

import nnz.adminservice.entity.AskedShow;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AskedShowRepository extends JpaRepository<AskedShow, Long> {
    List<AskedShow> findAllByStatus(AskedShow.AskedShowStatus status);
}
