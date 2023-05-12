package nnz.nanumservice.dto.res.show;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.Show;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResShowDTO {

    private String title;

    private String location;

    public static ResShowDTO of(Show show) {
        return ResShowDTO.builder()
                .title(show.getTitle())
                .location(show.getLocation())
                .build();
    }
}
