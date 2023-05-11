package nnz.showservice.repository;

import nnz.showservice.entity.Show;
import nnz.showservice.entity.ShowTag;
import nnz.showservice.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ShowTagRepository extends JpaRepository<ShowTag, Long> {

    List<ShowTag> findAllByTag(Tag tag);
}
