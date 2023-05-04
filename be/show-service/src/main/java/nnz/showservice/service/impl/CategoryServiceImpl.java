package nnz.showservice.service.impl;

import lombok.RequiredArgsConstructor;
import nnz.showservice.dto.CategoryDTO;
import nnz.showservice.entity.Category;
import nnz.showservice.repository.CategoryRepository;
import nnz.showservice.service.CategoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    @Override
    public List<CategoryDTO> readCategories(String parent) {

        try {
            List<Category> childCategories = categoryRepository.findAllByParentCode(parent);

            if (parent == null) {
                return childCategories
                        .stream()
                        .map(CategoryDTO::entityToDTO)
                        .collect(Collectors.toList());
            }
            return childCategories
                    .stream()
                    .map(CategoryDTO::entityToDTO)
                    .collect(Collectors.toList());
        } //
        catch (Exception e) {
            return new ArrayList<>();
        }
    }
}
