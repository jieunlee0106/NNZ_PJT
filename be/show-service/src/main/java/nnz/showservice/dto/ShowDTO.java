package nnz.showservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Show;
import org.springframework.data.domain.Page;

import java.time.LocalDateTime;
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

    private List<ShowTagDTO> showTags;

    private String poster;

    private String categoryCode;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

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
                .region(show.getRegion())
                .title(show.getTitle())
                .showTags(showTags)
                .updatedAt(show.getUpdatedAt())
                .build();
    }

    public static Page<ShowDTO> toPagingDTO(Page<Show> showPage) {
        return showPage.map(ShowDTO::entityToDTO);
    }
}
