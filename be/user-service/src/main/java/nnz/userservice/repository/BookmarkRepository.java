package nnz.userservice.repository;

import nnz.userservice.entity.Bookmark;
import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {

    Optional<Bookmark> findByUserAndNanum(User user, Nanum nanum);
}
