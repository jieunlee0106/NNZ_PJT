package nnz.adminservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.entity.Show;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShowKafkaDTO {
    private String category;

    private String title;

    private String location;

    private String startDate;

    private String endDate;

    private String ageLimit;
    private String region;

    private String poster;

    public static ShowKafkaDTO entityToDTO(Show show) {

        return ShowKafkaDTO.builder()
                .category(show.getCategory().getName())
                .ageLimit(show.getAgeLimit())
                .location(show.getLocation())
                .region(show.getRegion())
                .poster(show.getPosterImage())
                .startDate(show.getStartDate())
                .endDate(show.getEndDate())
                .title(show.getTitle())
                .build();
    }
}
