package nnz.tagservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.ShowTag;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ShowTagDTO {

    private Long id;

    private Long showId;

    private Long tagId;

    public static ShowTagDTO of(ShowTag showTag) {
        return ShowTagDTO.builder()
                .id(showTag.getId())
                .showId(showTag.getShow().getId())
                .tagId(showTag.getTag().getId())
                .build();
    }
}
