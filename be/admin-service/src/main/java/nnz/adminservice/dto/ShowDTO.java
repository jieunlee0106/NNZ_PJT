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

    private List<ShowTagDTO> showTags;

    private String poster;

    public static ShowDTO entityToDTO(Show show) {
        List<ShowTagDTO> showTags = show.getShowTags()
                .stream()
                .map(ShowTagDTO::entityToDTO)
                .collect(Collectors.toList());

        return ShowDTO.builder()
                .id(show.getId())
                .ageLimit(show.getAgeLimit())
                .location(show.getLocation())
                .poster(show.getPosterImage())
                .startDate(show.getStartDate())
                .endDate(show.getEndDate())
                .title(show.getTitle())
                .showTags(showTags)
                .build();
    }

    public static Page<ShowDTO> toPagingDTO(Page<Show> showPage) {
        return showPage.map(ShowDTO::entityToDTO);
    }
}

