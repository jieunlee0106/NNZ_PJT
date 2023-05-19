package nnz.showservice.repository;

import nnz.showservice.dto.CategoryDTO;
import nnz.showservice.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, String> {

    /**
     * 해당 카테고리가 있는지 (삭제되지 않은 데이터) db에 조회하는 메소드
     * @param category
     * @return
     */
    Optional<Category> findByName(String category);

    /**
     *
     * @param parent
     * @return
     */
    List<Category> findAllByParentCode(String parent);
}
