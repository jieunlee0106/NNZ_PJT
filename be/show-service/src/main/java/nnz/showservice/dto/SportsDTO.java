package nnz.showservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Show;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SportsDTO {

    private Long id;

    private String leftTeam;

    private String rightTeam;

    private String location;

    private String date;

    private String ageLimit;

    private List<ShowTagDTO> showTags;

    private String leftTeamImage;

    private String rightTeamImage;

    public static SportsDTO entityToDto(Show show) {
        String[] team = show.getTitle().split("vs");
        String leftTeam = team[0];
        String rightTeam = team[1];
        String leftTeamImage = null;
        String rightTeamImage = null;

        if (show.getPosterImage() != null) {
            String[] teamImages = show.getPosterImage().split("vs");
            leftTeamImage = teamImages[0];
            rightTeamImage = teamImages[1];
        }

        List<ShowTagDTO> showTags = show.getShowTags()
                .stream()
                .map(ShowTagDTO::entityToDTO)
                .collect(Collectors.toList());

        return SportsDTO.builder()
                .id(show.getId())
                .ageLimit(show.getAgeLimit())
                .location(show.getLocation())
                .leftTeam(leftTeam)
                .rightTeam(rightTeam)
                .leftTeamImage(leftTeamImage)
                .rightTeamImage(rightTeamImage)
                .date(show.getStartDate())
                .showTags(showTags)
                .build();
    }
}
