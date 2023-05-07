package nnz.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.Nanum;

import java.util.List;
import java.util.stream.Collectors;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class BookmarkedNanumDTO {

    private Long id;
    private String title;
    private String thumbnail;
    private Integer status;
    List<NanumTagDTO> tags;
    private ShowDTO show;

    public static BookmarkedNanumDTO of(Nanum nanum) {
        ShowDTO showDTO = ShowDTO.of(nanum.getShow());
        List<NanumTagDTO> tags = nanum.getTags().stream()
                .map(NanumTagDTO::of)
                .collect(Collectors.toList());

        return BookmarkedNanumDTO.builder()
                .id(nanum.getId())
                .title(nanum.getTitle())
                .thumbnail(nanum.getThumbnail())
                .status(nanum.getStatus().getStatus())
                .show(showDTO)
                .tags(tags)
                .build();
    }
}
