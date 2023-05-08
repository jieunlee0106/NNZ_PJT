package com.example.nnzcrawling.dto;

import com.example.nnzcrawling.entity.Show;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShowDTO {

    private Long id;

    private String title;

    private String location;

    private String startDate;

    private String endDate;

    private String ageLimit;

    private String region;

    private String posterImage;

    private String categoryCode;

    private Long createdBy;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime createdAt;

    private Long updatedBy;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    protected boolean isDelete;

    public static ShowDTO of(Show show) {
        return ShowDTO.builder()
                .id(show.getId())
                .title(show.getTitle())
                .location(show.getLocation())
                .startDate(show.getStartDate())
                .endDate(show.getEndDate())
                .ageLimit(show.getAgeLimit())
                .region(show.getRegion())
                .posterImage(show.getPosterImage())
                .categoryCode(show.getCategory().getCode())
                .createdBy(show.getCreatedBy())
                .createdAt(show.getCreatedAt())
                .updatedBy(show.getUpdatedBy())
                .updatedAt(show.getUpdatedAt())
                .isDelete(show.getIsDelete())
                .build();
    }
}
