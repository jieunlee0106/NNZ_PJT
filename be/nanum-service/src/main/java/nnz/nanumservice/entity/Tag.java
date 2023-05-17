package nnz.nanumservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import nnz.nanumservice.dto.TagDTO;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "tags")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@ToString
public class Tag {

    @Id
    private Long id;

    private String tag;

    private Integer views;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    public static Tag of(TagDTO tagDTO) {
        return Tag.builder()
                .id(tagDTO.getId())
                .tag(tagDTO.getTag())
                .updatedAt(tagDTO.getUpdatedAt())
                .build();
    }

    public void updateViews(Integer views) {
        this.views = views;
    }
}
