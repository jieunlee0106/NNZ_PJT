package nnz.showservice.dto.res;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Show;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ResSearchShowDTO {

    private Long id;
    private String title;
    private String startDate;
    private String endDate;
    private String location;
    private String poster;

    @Builder.Default
    private List<ResTagDTO> tags = new ArrayList<>();

    public static ResSearchShowDTO of(Show show) {
        List<ResTagDTO> tags = show.getShowTags().stream()
                .map(st -> ResTagDTO.of(st.getTag()))
                .collect(Collectors.toList());

        return ResSearchShowDTO.builder()
                .id(show.getId())
                .title(show.getTitle())
                .startDate(show.getStartDate())
                .endDate(show.getEndDate())
                .location(show.getLocation())
                .poster(show.getPosterImage())
                .tags(tags)
                .build();
    }
}
