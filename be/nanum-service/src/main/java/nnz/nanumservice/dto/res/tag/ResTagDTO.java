package nnz.nanumservice.dto.res.tag;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.NanumTag;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResTagDTO {

    private Long id;

    private String tag;

    public static ResTagDTO of(NanumTag nanumTag) {
        return ResTagDTO.builder()
                .id(nanumTag.getId())
                .tag(nanumTag.getTag().getTag())
                .build();
    }
}
