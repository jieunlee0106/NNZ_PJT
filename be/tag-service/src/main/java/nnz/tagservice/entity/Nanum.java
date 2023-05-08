package nnz.tagservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.dto.NanumDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "nanums")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Nanum {

    @Id
    private Long id;

    private String title;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static Nanum of(NanumDTO nanumDTO) {
        return Nanum.builder()
                .id(nanumDTO.getId())
                .title(nanumDTO.getTitle())
                .updatedAt(nanumDTO.getUpdatedAt())
                .isDelete(nanumDTO.isDelete())
                .build();
    }
}
