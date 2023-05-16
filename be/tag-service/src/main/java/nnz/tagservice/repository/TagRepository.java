package nnz.tagservice.repository;

import nnz.tagservice.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Long> {

    Optional<Tag> findByTag(String tagName);

    List<Tag> findTop12ByOrderByViewsDesc();

    List<Tag> findAllByTagContaining(String search);
}
