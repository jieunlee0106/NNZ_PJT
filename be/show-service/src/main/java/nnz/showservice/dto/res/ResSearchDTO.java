package nnz.showservice.dto.res;

import io.github.eello.nnz.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.entity.Show;
import org.springframework.data.domain.Page;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ResSearchDTO {

    private PageDTO shows;
    private List<ResTagDTO> relatedTags;

    public static ResSearchDTO of(Page<Show> page, List<ResTagDTO> tags) {
        return ResSearchDTO.builder()
                .shows(PageDTO.of(page.map(ResSearchShowDTO::of)))
                .relatedTags(tags)
                .build();
    }
}
