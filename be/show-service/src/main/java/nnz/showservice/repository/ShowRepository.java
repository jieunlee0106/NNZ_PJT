package nnz.showservice.repository;

import nnz.showservice.entity.Category;
import nnz.showservice.entity.Show;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ShowRepository extends JpaRepository<Show, Long> {

    Page<Show> findByCategoryAndIsDeleteFalse(Category category, Pageable pageable);

    Page<Show> findByCategoryAndTitleContainingAndIsDeleteFalse(Category category, String title, PageRequest pageRequest);

    List<Show> findAllByCategory(Category category);

    @Query("select distinct s from Show s " +
            "join s.showTags st " +
            "where s.title like %:query% or " +
            "st.tag.tag like %:query%")
    Page<Show> findByQuery(String query, Pageable pageable);
}
