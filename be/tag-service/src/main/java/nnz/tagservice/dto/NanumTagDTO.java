package nnz.tagservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.NanumTag;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class NanumTagDTO {

    private Long id;

    private Long nanumId;

    private Long tagId;

    public static NanumTagDTO of(NanumTag nanumTag) {
        return NanumTagDTO.builder()
                .id(nanumTag.getId())
                .nanumId(nanumTag.getNanum().getId())
                .tagId(nanumTag.getTag().getId())
                .build();
    }
}
