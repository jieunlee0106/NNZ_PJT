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
}
