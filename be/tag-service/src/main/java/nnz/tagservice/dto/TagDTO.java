package nnz.tagservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.Tag;

import java.util.Optional;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class TagDTO {

    private Long id;

    private String title;

    private String tag;

    private Integer viwes;

    public static TagDTO of(Tag tag) {
        return TagDTO.builder()
                .id(tag.getId())
                .tag(tag.getTag())
                .viwes(tag.getViews())
                .build();
    }
}
