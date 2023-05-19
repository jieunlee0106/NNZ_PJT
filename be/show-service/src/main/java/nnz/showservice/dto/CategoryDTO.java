package nnz.showservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Category;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDTO {

    private String code;

    private String name;

    public static CategoryDTO entityToDTO(Category category) {
        return CategoryDTO.builder()
                .code(category.getCode())
                .name(category.getName())
                .build();
    }
}
