package nnz.tagservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.dto.ShowDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "shows")
@Getter
@NoArgsConstructor
@AllArgsConstructor
<<<<<<< HEAD:be/nnz-crawling/src/main/java/com/example/nnzcrawling/entity/ShowTag.java
public class ShowTag extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
=======
@Builder
public class Show {

    @Id
    private Long id;
>>>>>>> 2ae0ba79e5b1b1f598881469727b48faebe76769:be/tag-service/src/main/java/nnz/tagservice/entity/Show.java

    private String title;

//    @JsonSerialize(using = LocalDateTimeSerializer.class)
//    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
//    private LocalDateTime updatedAt;
//
//    protected boolean isDelete;

<<<<<<< HEAD:be/nnz-crawling/src/main/java/com/example/nnzcrawling/entity/ShowTag.java
    public void setShow(Show show) {
        this.show = show;
    }

    public static ShowTag of(ShowTagDTO showTagDTO, Show show, Tag tag) {
        return ShowTag.builder()
                .id(showTagDTO.getId())
                .show(show)
                .tag(tag)
=======
    private boolean isDelete;

    public static Show of(ShowDTO showDTO) {
        return Show.builder()
                .id(showDTO.getId())
                .title(showDTO.getTitle())
                .updatedAt(showDTO.getUpdatedAt())
                .isDelete(showDTO.isDelete())
>>>>>>> 2ae0ba79e5b1b1f598881469727b48faebe76769:be/tag-service/src/main/java/nnz/tagservice/entity/Show.java
                .build();
    }
}
