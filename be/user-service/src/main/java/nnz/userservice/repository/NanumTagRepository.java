package nnz.userservice.repository;

import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.NanumTag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NanumTagRepository extends JpaRepository<NanumTag, Long> {

    List<NanumTag> findByNanumIn(List<Nanum> nanums);

    void deleteByNanum(Nanum nanum);
}
