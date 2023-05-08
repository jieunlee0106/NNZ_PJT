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
@Builder
public class Show {

    @Id
    private Long id;

    private String title;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static Show of(ShowDTO showDTO) {
        return Show.builder()
                .id(showDTO.getId())
                .title(showDTO.getTitle())
                .updatedAt(showDTO.getUpdatedAt())
                .isDelete(showDTO.isDelete())
                .build();
    }
}
