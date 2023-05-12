package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Bookmark;
import nnz.nanumservice.entity.Nanum;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {

    List<Bookmark> findAllByNanum(Nanum nanum);
}
