package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.Show;
import nnz.nanumservice.entity.Tag;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Long> {

    Optional<Tag> findByTag(String nanumTagName);

    @Query("select distinct t  from Tag t " +
            "join NanumTag nt on t.id = nt.tag.id " +
            "where nt.nanum in :nanums")
    List<Tag> findByNanum(@Param("nanums") List<Nanum> nanums, Pageable pageable);

    @Query("select distinct t from Tag t " +
            "join NanumTag nt on t.id = nt.tag.id " +
            "join nt.nanum.show s " +
            "where s.id in :showIds")
    List<Tag> findByShowId(@Param("showIds") List<Long> showIds, Pageable pageable);
}
