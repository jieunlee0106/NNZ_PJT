package nnz.showservice.dto.res;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.dto.BannerDTO;
import nnz.showservice.entity.Banner;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResBannerDTO {

    private Long id;

    private String image;

    private Long showId;

    public static ResBannerDTO of(Banner banner) {
        return ResBannerDTO.builder()
                .id(banner.getId())
                .image(banner.getImage())
                .showId(banner.getShow().getId())
                .build();
    }
}
