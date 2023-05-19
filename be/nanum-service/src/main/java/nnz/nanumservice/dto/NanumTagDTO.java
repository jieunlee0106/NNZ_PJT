package nnz.nanumservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.NanumTag;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NanumTagDTO {

    private Long id;

    private Long nanumId;

    private TagDTO tag;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    public static NanumTagDTO of(NanumTag nanumTag) {
        NanumTagDTO dto = new NanumTagDTO();
        dto.id = nanumTag.getId();
        dto.nanumId = nanumTag.getNanum().getId();
        dto.tag = TagDTO.of(nanumTag.getTag());
        dto.updatedAt = nanumTag.getUpdatedAt();
        return dto;
    }
}
