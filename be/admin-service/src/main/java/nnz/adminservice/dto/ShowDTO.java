package nnz.adminservice.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.entity.Show;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShowDTO {

    private Long id;

    private String title;

    private String location;

    private String startDate;

    private String endDate;

    private String ageLimit;
    private String region;

    private String poster;

    public static ShowDTO entityToDTO(Show show) {

        return ShowDTO.builder()
                .id(show.getId())
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

