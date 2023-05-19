package com.example.nnzcrawling.dto;

import com.example.nnzcrawling.entity.Show;
import com.example.nnzcrawling.entity.ShowTag;
import com.example.nnzcrawling.entity.Tag;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ShowSyncDTO {

    private Long id;
    private String title;
    private String location;
    private String startDate;
    private String endDate;
    private String ageLimit;
    private String region;
    private String posterImage;
    private String categoryCode;
    private List<ShowTagSyncDTO> tags;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    private LocalDateTime updatedAt;
    private Boolean isDelete;

    public static ShowSyncDTO of(Show show) {
        List<ShowTagSyncDTO> syncTags = show.getTags().stream()
                .map(ShowTagSyncDTO::of)
                .collect(Collectors.toList());

        return ShowSyncDTO.builder()
                .id(show.getId())
                .title(show.getTitle())
                .location(show.getLocation())
                .startDate(show.getStartDate())
                .endDate(show.getEndDate())
                .ageLimit(show.getAgeLimit())
                .region(show.getRegion())
                .posterImage(show.getPosterImage())
                .categoryCode(show.getCategory().getCode())
                .tags(syncTags)
                .updatedAt(show.getUpdatedAt())
                .isDelete(show.getIsDelete())
                .build();

    }


    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    @Getter
    private static class ShowTagSyncDTO {
        private Long id;
        private TagSyncDTO tag;

        @JsonSerialize(using = LocalDateTimeSerializer.class)
        private LocalDateTime updatedAt;
        private Boolean isDelete;

        public static ShowTagSyncDTO of(ShowTag showTag) {
            TagSyncDTO tag = TagSyncDTO.of(showTag.getTag());
            return ShowTagSyncDTO.builder()
                    .id(showTag.getId())
                    .tag(tag)
                    .updatedAt(showTag.getUpdatedAt())
                    .isDelete(showTag.getIsDelete())
                    .build();
        }

    }

    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    @Getter
    private static class TagSyncDTO {
        private Long id;
        private String tag;
        private Integer views;

        @JsonSerialize(using = LocalDateTimeSerializer.class)
        private LocalDateTime updatedAt;
        private Boolean isDelete;

        public static TagSyncDTO of(Tag tag) {
            return TagSyncDTO.builder()
                    .id(tag.getId())
                    .tag(tag.getTag())
                    .views(tag.getViews())
                    .updatedAt(tag.getUpdatedAt())
                    .isDelete(tag.isDelete())
                    .build();
        }
    }
}
