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
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "shows")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Where(clause = "is_delete = 0")
public class Show {

    @Id
    private Long id;

    private String title;

    private String location;

    private String endDate;

    private String startDate;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static Show of(ShowDTO showDTO) {
        return Show.builder()
                .id(showDTO.getId())
                .startDate(showDTO.getStartDate())
                .endDate(showDTO.getEndDate())
                .location(showDTO.getLocation())
                .title(showDTO.getTitle())
                .updatedAt(showDTO.getUpdatedAt())
                .build();
    }

    public void updateShow(ShowDTO showDTO) {
        this.id = showDTO.getId();
        this.startDate = showDTO.getStartDate();
        this.endDate = showDTO.getEndDate();
        this.location = showDTO.getLocation();
        this.title = showDTO.getTitle();
        this.updatedAt = showDTO.getUpdatedAt();
    }

    public void deleteShow() {
        this.isDelete = true;
    }
}
