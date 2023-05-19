package nnz.userservice.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.NanumTag;

@NoArgsConstructor
@Getter
public class NanumTagDTO {

    private Long id;
    private String tag;

    public static NanumTagDTO of(NanumTag nanumTag) {
        NanumTagDTO dto = new NanumTagDTO();
        dto.id = nanumTag.getId();
        dto.tag = nanumTag.getTag();
        return dto;
    }
}
