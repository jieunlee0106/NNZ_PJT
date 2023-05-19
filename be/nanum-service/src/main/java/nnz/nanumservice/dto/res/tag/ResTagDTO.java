package nnz.nanumservice.dto.res.tag;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.NanumTag;
import nnz.nanumservice.entity.Tag;

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

    public static ResTagDTO of(Tag tag) {
        return ResTagDTO.builder()
                .id(tag.getId())
                .tag(tag.getTag())
                .build();
    }
}
