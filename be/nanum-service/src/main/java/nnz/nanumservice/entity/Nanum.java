package nnz.nanumservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.NanumInfoDTO;
import nnz.nanumservice.vo.NanumVO;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "nanums")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Where(clause = "is_delete = 0")
public class Nanum extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "provider_id")
    private User provider;

    private String title;

    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate nanumDate;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime openTime;

    private Boolean isCertification;

    private String condition;

    // 전체 수량
    private Integer quantity;

    // 남은 수량
    private Integer stock;

    private String content;

    // 나눔 진행상태 = 나눔 전(0), 마감(1), 나눔 중(2), 종료(3)
    private Integer status;

    // 썸네일 이미지 주소
    private String thumbnail;

    private Integer views;

    @Embedded
    private NanumInfo nanumInfo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    private Show show;

    @OneToMany(mappedBy = "nanum")
    private final List<NanumImage> thumbnails = new ArrayList<>();

    @OneToMany(mappedBy = "nanum")
    private final List<NanumTag> tags = new ArrayList<>();

    public static Nanum voToEntity(NanumVO data, User user, Show show) {
        NanumInfo nanumInfo = NanumInfo.builder()
                .lat(null)
                .lng(null)
                .location(null)
                .nanumTime(null)
                .outfit(null)
                .build();

        return Nanum.builder()
                .title(data.getTitle())
                .openTime(data.getOpenTime())
                .isCertification(data.getIsCertification())
                .condition(data.getCondition())
                .nanumDate(data.getNanumDate())
                .quantity(data.getQuantity())
                .stock(data.getQuantity())
                .content(data.getContent())
                .status(0)
                .views(0)
                .provider(user)
                .show(show)
                .nanumInfo(nanumInfo)
                .build();
    }

    public void updateThumbnail(String path) {
        this.thumbnail = path;
    }

    public NanumInfo getNanumInfo() {
        return this.nanumInfo == null ? new NanumInfo() : this.nanumInfo;
    }

    public void setNanumInfo(NanumInfoDTO nanumInfoDTO) {
        this.nanumInfo = NanumInfo.of(nanumInfoDTO);
    }

    public void plusViews() {
        this.views += 1;
    }

    public void updateStatus(int status) {
        this.status = status;
    }

    public void updateStock(int stock) {
        this.stock = stock;
    }

    public void updateNanum(NanumVO data) {
        this.nanumDate = data.getNanumDate() != null ? data.getNanumDate() : this.nanumDate;
        this.title = data.getTitle() != null ? data.getTitle() : this.title;
        this.openTime = data.getOpenTime() != null ? data.getOpenTime() : this.openTime;
        this.isCertification = data.getIsCertification() != null ? data.getIsCertification() : this.isCertification;
        this.condition = data.getCondition() != null ? data.getCondition() : this.condition;
        this.quantity = data.getQuantity() != null ? data.getQuantity() : this.quantity;
        this.content = data.getContent() != null ? data.getContent() : this.content;
    }

    public void deleteNanum() {
        this.isDelete = true;
    }
}
