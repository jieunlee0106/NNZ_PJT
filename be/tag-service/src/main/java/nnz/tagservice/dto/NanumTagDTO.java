package nnz.tagservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.NanumTag;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class NanumTagDTO {

    private Long id;

    private Long nanumId;

    private Long tagId;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static NanumTagDTO of(NanumTag nanumTag) {
        return NanumTagDTO.builder()
                .id(nanumTag.getId())
                .nanumId(nanumTag.getNanum().getId())
                .tagId(nanumTag.getTag().getId())
                .updatedAt(nanumTag.getUpdatedAt())
                .isDelete(nanumTag.getIsDelete())
                .build();
    }
}
