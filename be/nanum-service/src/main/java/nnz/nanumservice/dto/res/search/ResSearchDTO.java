package nnz.nanumservice.dto.res.search;

import io.github.eello.nnz.common.dto.PageDTO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.res.nanum.ResNanumDTO;
import nnz.nanumservice.dto.res.nanum.ResSearchNanumDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.Tag;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.stream.Collectors;

@NoArgsConstructor
@Getter
public class ResSearchDTO {

    private PageDTO nanums;
    private List<ResTagDTO> relatedTags;

    public static ResSearchDTO of(Page<Nanum> page, List<Tag> tags) {
        ResSearchDTO dto = new ResSearchDTO();
        dto.nanums = PageDTO.of(page.map(ResSearchNanumDTO::of));
        dto.relatedTags = tags.stream()
                .map(ResTagDTO::of)
                .collect(Collectors.toList());
        return dto;
    }
}
