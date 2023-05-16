package nnz.showservice.dto.res;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Tag;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ResTagDTO {

    private Long id;
    private String tag;

    public static ResTagDTO of(Tag tag) {
        return ResTagDTO.builder()
                .id(tag.getId())
                .tag(tag.getTag())
                .build();
    }
}
