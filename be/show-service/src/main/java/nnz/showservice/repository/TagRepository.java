package nnz.showservice.repository;

import nnz.showservice.entity.Tag;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Long> {

    Optional<Tag> findByTag(String showTagName);

    @Query("select t from Tag t " +
            "join ShowTag st on t.id = st.tag.id " +
            "where st.show.id = :showId")
    List<Tag> findTagByShow(Long showId, Pageable pageable);
}
