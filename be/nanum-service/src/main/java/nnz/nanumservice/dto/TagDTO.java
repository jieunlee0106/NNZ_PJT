package nnz.nanumservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.Tag;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class TagDTO {

    private String title;

    private String type;

    private Long id;

    private String tag;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    public TagDTO(String title, String tag, String type) {
        this.title = title;
        this.tag = tag;
        this.type = type;
    }

    public static TagDTO of(Tag tag) {
        TagDTO dto = new TagDTO();
        dto.id = tag.getId();
        dto.tag = tag.getTag();
        dto.updatedAt = tag.getUpdatedAt();
        return dto;
    }
}
