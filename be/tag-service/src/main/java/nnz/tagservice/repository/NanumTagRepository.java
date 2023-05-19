package nnz.tagservice.repository;

import nnz.tagservice.entity.Nanum;
import nnz.tagservice.entity.NanumTag;
import nnz.tagservice.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface NanumTagRepository extends JpaRepository<NanumTag, Long> {

    Optional<NanumTag> findByNanumAndTag(Nanum nanum, Tag tag);
}
