package nnz.userservice.repository;

import nnz.userservice.entity.Bookmark;
import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {

    Optional<Bookmark> findByUserAndNanum(User user, Nanum nanum);

    @Query("select bm.nanum from Bookmark bm " +
//            "join fetch bm.nanum.tags t " +
            "join fetch bm.nanum.show s " +
            "where bm.user = :user")
    List<Nanum> findNanumByUser(@Param("user") User user);
}
