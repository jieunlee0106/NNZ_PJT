package com.example.nnzcrawling.entity;

import com.example.nnzcrawling.dto.TagDTO;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "tags")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class Tag {

    @Id
    private Long id;

    private String tag;

    // 조회수
    private Integer views;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    protected boolean isDelete;

    public static Tag of(TagDTO tagDTO) {
        return Tag.builder()
                .id(tagDTO.getId())
                .tag(tagDTO.getTag())
                .views(tagDTO.getViews())
                .updatedAt(tagDTO.getUpdatedAt())
                .isDelete(tagDTO.isDelete())
                .build();
    }
}
