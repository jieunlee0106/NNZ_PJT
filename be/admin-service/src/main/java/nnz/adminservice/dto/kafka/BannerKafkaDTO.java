package nnz.adminservice.dto.kafka;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
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
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime createdAt;
    private Long updateBy;
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
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
