package nnz.showservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.showservice.dto.BannerDTO;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "banners")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Where(clause = "is_delete = 0")
public class Banner {

    @Id
    private Long id;

    private String image;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    private Show show;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public void updateBanner(BannerDTO bannerDTO, Show show) {
        this.id = bannerDTO.getId();
        this.image = bannerDTO.getImage();
        this.show = show;
        this.updatedAt = bannerDTO.getUpdatedAt();
    }

    public void deleteBanner(LocalDateTime updatedAt) {
        this.isDelete = true;
        this.updatedAt = updatedAt;
    }
}
