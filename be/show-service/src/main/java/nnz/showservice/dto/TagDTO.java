package nnz.showservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Tag;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TagDTO {

    private Long id;
    private String tag;
    private Integer views;

    public static TagDTO of(Tag tag) {
        return TagDTO.builder()
                .id(tag.getId())
                .tag(tag.getTag())
                .views(tag.getViews())
                .build();
    }
}
