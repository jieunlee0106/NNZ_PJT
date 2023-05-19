package nnz.showservice.dto.res;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Show;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResShowDTO {

    private Long id;

    private String title;

    private String poster;

    public static ResShowDTO of(Show show) {
        return ResShowDTO.builder()
                .id(show.getId())
                .title(show.getTitle())
                .poster(show.getPosterImage())
                .build();
    }
}
