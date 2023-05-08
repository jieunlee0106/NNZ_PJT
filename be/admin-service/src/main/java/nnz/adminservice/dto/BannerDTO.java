package nnz.adminservice.dto;

import lombok.Builder;
import lombok.Getter;
import nnz.adminservice.entity.Show;

@Getter
@Builder
public class BannerDTO {
    private Long id;
    private String image;
    private Long showId;
}
