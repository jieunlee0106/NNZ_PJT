package nnz.nanumservice.repository;

import nnz.nanumservice.entity.NanumTag;
import nnz.nanumservice.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NanumTagRepository extends JpaRepository<NanumTag, Long> {

    List<NanumTag> findAllByTag(Tag tag);
}
