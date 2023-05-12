package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Bookmark;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {

    List<Bookmark> findAllByNanum(Nanum nanum);

    Optional<Bookmark> findByNanumAndUser(Nanum nanum, User follower);
}
