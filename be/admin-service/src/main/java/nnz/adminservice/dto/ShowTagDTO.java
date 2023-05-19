package nnz.adminservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.entity.ShowTag;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShowTagDTO {

    private Long id;

    private String tag;

    public static ShowTagDTO entityToDTO(ShowTag showTag) {
        return ShowTagDTO.builder()
                .id(showTag.getId())
                .tag(showTag.getTag().getTag())
                .build();
    }
}
