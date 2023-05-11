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

    private Integer quantity;

    private Integer stock;

    private String content;

    // 나눔 진행상태 = 나눔 전(0), 나눔 중(1), 마감(2), 종료(3)
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
    private List<NanumImage> thumbnails = new ArrayList<>();

    @OneToMany(mappedBy = "nanum")
    private List<NanumTag> tags = new ArrayList<>();

    public static Nanum voToEntity(NanumVO data, User user, Show show) {
        // todo : 기본 값 처리 어떻게 할 것인지
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

    public void updateStatus(int status) {
        this.status = status;
    }
}
