package nnz.tagservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
<<<<<<< HEAD:be/nnz-crawling/src/main/java/com/example/nnzcrawling/dto/TagDTO.java
import lombok.ToString;
=======
import nnz.tagservice.entity.Tag;
>>>>>>> 2ae0ba79e5b1b1f598881469727b48faebe76769:be/tag-service/src/main/java/nnz/tagservice/dto/TagDTO.java

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
<<<<<<< HEAD:be/nnz-crawling/src/main/java/com/example/nnzcrawling/dto/TagDTO.java
@ToString(of = {"id", "tag", "title"})
=======
@Builder
@Getter
>>>>>>> 2ae0ba79e5b1b1f598881469727b48faebe76769:be/tag-service/src/main/java/nnz/tagservice/dto/TagDTO.java
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
