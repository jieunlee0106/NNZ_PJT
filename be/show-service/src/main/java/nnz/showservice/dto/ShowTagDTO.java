package nnz.showservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.ShowTag;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShowTagDTO {

    private Long id;

    private String tagName;

    private Long showId;

    private Long tagId;

    public static ShowTagDTO entityToDTO(ShowTag showTag) {
        return ShowTagDTO.builder()
                .id(showTag.getId())
                .tagName(showTag.getTag().getTag())
                .build();
    }
}
