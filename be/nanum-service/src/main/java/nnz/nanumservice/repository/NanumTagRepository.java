package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.NanumTag;
import nnz.nanumservice.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface NanumTagRepository extends JpaRepository<NanumTag, Long> {

    List<NanumTag> findAllByTag(Tag tag);

    Optional<NanumTag> findByNanumAndTag(Nanum nanum, Tag tag);
}
