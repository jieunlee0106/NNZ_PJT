package nnz.userservice.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.Show;

@NoArgsConstructor
@Getter
public class ShowDTO {

    private Long id;
    private String title;
    private String location;

    public static ShowDTO of(Show show) {
        ShowDTO dto = new ShowDTO();
        dto.id = show.getId();
        dto.title = show.getTitle();
        dto.location = show.getLocation();
        return dto;
    }
}
