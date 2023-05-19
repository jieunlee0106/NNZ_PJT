package nnz.tagservice.repository;

import nnz.tagservice.entity.Show;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShowRepository extends JpaRepository<Show, Long> {

    List<Show> findByTitleContaining(String title);
}
