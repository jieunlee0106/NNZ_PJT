package nnz.tagservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.ShowTag;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ShowTagDTO {

    private Long id;

    private Long showId;

    private Long tagId;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static ShowTagDTO of(ShowTag showTag) {
        return ShowTagDTO.builder()
                .id(showTag.getId())
                .showId(showTag.getShow().getId())
                .tagId(showTag.getTag().getId())
                .updatedAt(showTag.getUpdatedAt())
                .isDelete(showTag.getIsDelete())
                .build();
    }
}
