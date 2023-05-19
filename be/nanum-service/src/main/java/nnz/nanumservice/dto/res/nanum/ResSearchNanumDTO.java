package nnz.nanumservice.dto.res.nanum;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.res.show.ResShowDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.NanumTag;
import nnz.nanumservice.entity.Tag;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ResSearchNanumDTO {

    private Long id;
    private String thumbnail;
    private String title;
    private LocalDate nanumDate;
    private List<ResTagDTO> tags;
    private ResShowDTO show;

    public static ResSearchNanumDTO of(Nanum nanum) {
        List<ResTagDTO> tags = nanum.getTags().stream()
                .map(st -> ResTagDTO.of(st.getTag()))
                .collect(Collectors.toList());
        ResShowDTO show = ResShowDTO.of(nanum.getShow());

        return ResSearchNanumDTO.builder()
                .id(nanum.getId())
                .thumbnail(nanum.getThumbnail())
                .title(nanum.getTitle())
                .nanumDate(nanum.getNanumDate())
                .tags(tags)
                .show(show)
                .build();
    }
}