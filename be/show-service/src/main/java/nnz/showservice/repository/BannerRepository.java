package nnz.showservice.repository;

import nnz.showservice.entity.Banner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BannerRepository extends JpaRepository<Banner, Long> {

    List<Banner> findTop3ByOrderByUpdatedAtDesc();
}
