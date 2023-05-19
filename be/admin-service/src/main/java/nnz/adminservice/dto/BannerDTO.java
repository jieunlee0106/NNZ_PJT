package nnz.adminservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.entity.Show;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BannerDTO {
    private Long id;
    private String image;
    private Long showId;
}
