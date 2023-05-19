package nnz.adminservice.entity;


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
import nnz.adminservice.dto.kafka.NanumKafkaDTO;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "nanums")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Nanum extends BaseEntity {

    @Id
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

    public static Nanum toEntity(NanumKafkaDTO data, User user, Show show) {
        NanumInfo nanumInfo = NanumInfo.builder()
                .lat(data.getLat())
                .lng(data.getLng())
                .location(data.getLocation())
                .nanumTime(data.getNanumTime())
                .outfit(data.getOutfit())
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
                .status(data.getStatus())
                .views(data.getViews())
                .provider(user)
                .show(show)
                .nanumInfo(nanumInfo)
                .build();
    }
}

