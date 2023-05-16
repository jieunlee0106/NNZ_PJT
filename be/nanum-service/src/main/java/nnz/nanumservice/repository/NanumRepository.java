package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.Show;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface NanumRepository extends JpaRepository<Nanum, Long> {

    Page<Nanum> findByShowAndIsDeleteFalse(Show show, Pageable pageRequest);

    List<Nanum> findAllByStatus(int status);

    List<Nanum> findAllByStatusLessThan(int status);

    @Query("select distinct n from Nanum n " +
            "join n.show s " +
            "join n.tags st " +
            "where n.title like %:query% or " +
            "s.title like %:query% or " +
            "st.tag.tag like %:query%")
    Page<Nanum> findByQuery(@Param("query") String query, Pageable pageable);

    List<Nanum> findAllByOpenTimeBetween(LocalDateTime start, LocalDateTime end);

    List<Nanum> findAllByNanumDate(LocalDate today);
}
