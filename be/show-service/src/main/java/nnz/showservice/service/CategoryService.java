package nnz.showservice.service;

import nnz.showservice.dto.CategoryDTO;
import java.util.List;

public interface CategoryService {

    List<CategoryDTO> readCategories(String parent);
}
