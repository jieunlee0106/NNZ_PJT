package nnz.adminservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.entity.Banner;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BannerKafkaDTO {
    private Long id;
    private String image;
    private Long showId;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updateBy;
    private LocalDateTime updatedAt;

    public static BannerKafkaDTO toDTO(Banner banner){
        BannerKafkaDTO dto = new BannerKafkaDTO();
        dto.id = banner.getId();
        dto.image = banner.getImage();
        dto.showId = banner.getShow().getId();
        dto.createdBy = banner.getCreatedBy();
        dto.createdAt = banner.getCreatedAt();
        dto.updateBy = banner.getUpdatedBy();
        dto.updatedAt = banner.getUpdatedAt();
        return dto;
    }
}
