package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.NanumImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NanumImageRepository extends JpaRepository<NanumImage, Long> {

    List<NanumImage> findAllByNanum(Nanum nanum);
}
