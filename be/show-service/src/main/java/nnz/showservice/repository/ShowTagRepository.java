package nnz.showservice.repository;

import nnz.showservice.entity.Show;
import nnz.showservice.entity.ShowTag;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ShowTagRepository extends JpaRepository<ShowTag, Long> {

    /**
     * 공연 정보 조회 시 ShowDTO 안에 들어갈 tags(TagDTO를 위한 리스트)
     * @param show
     * @return
     */
    List<ShowTag> findAllByShow(Show show);
}
