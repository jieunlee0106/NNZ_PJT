package nnz.tagservice.repository;

import nnz.tagservice.entity.Show;
import nnz.tagservice.entity.ShowTag;
import nnz.tagservice.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ShowTagRepository extends JpaRepository<ShowTag, Long> {

    Optional<ShowTag> findByShowAndTag(Show show, Tag tag);
}
