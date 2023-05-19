package nnz.nanumservice.dto.res.nanum;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.res.show.ResNanumDetailShowDTO;
import nnz.nanumservice.dto.res.show.ResShowDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.entity.Nanum;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResNanumDTO {

    private Long id;

    private String title;

    private String thumbnail;

    private List<ResTagDTO> tags;

    private Integer status;

    private ResShowDTO show;

    public static ResNanumDTO of(Nanum nanum) {

        List<ResTagDTO> tags = new ArrayList<>();
        nanum.getTags().forEach(nanumTag -> {
            tags.add(ResTagDTO.of(nanumTag));
        });

        return ResNanumDTO.builder()
                .id(nanum.getId())
                .title(nanum.getTitle())
                .thumbnail(nanum.getThumbnail())
                .tags(tags)
                .status(nanum.getStatus())
                .show(ResShowDTO.of(nanum.getShow()))
                .build();
    }
}
