package nnz.nanumservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.ShowDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "shows")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Show {

    @Id
    private Long id;

    private String title;

    private String endDate;

    private String startDate;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    public static Show of(ShowDTO showDTO) {
        return Show.builder()
                .id(showDTO.getId())
                .startDate(showDTO.getStartDate())
                .endDate(showDTO.getEndDate())
                .title(showDTO.getTitle())
                .updatedAt(showDTO.getUpdatedAt())
                .build();
    }

//    private String posterImage;
//
//    private String region;
//
//    private String ageLimit;
//
//    private String location;
}
