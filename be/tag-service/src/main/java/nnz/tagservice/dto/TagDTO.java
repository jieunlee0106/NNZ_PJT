package nnz.tagservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.Tag;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class TagDTO {

    private Long id;

    private String title;

    private String tag;

    private Integer views;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static TagDTO of(Tag tag) {
        return TagDTO.builder()
                .id(tag.getId())
                .tag(tag.getTag())
                .views(tag.getViews())
                .updatedAt(tag.getUpdatedAt())
                .isDelete(tag.getIsDelete())
                .build();
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
