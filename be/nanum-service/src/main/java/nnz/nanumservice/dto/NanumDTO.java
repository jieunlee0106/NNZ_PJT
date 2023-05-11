package nnz.nanumservice.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.NanumInfo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class NanumDTO {

    private Long id;

    private Long providerId;

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

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime nanumTime;

    private String location;

    private Double lat;

    private Double lng;

    private String outfit;

    private Long showId;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List<NanumImageDTO> nanumImages;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List<NanumTagDTO> nanumTags;

    public static NanumDTO of(Nanum nanum) {
        NanumInfo nanumInfo = nanum.getNanumInfo();
        return NanumDTO.builder()
                .id(nanum.getId())
                .condition(nanum.getCondition())
                .content(nanum.getContent())
                .title(nanum.getTitle())
                .isCertification(nanum.getIsCertification())
                .openTime(nanum.getOpenTime())
                .quantity(nanum.getQuantity())
                .stock(nanum.getStock())
                .thumbnail(nanum.getThumbnail())
                .status(nanum.getStatus())
                .nanumTime(nanumInfo.getNanumTime())
                .lat(nanumInfo.getLat())
                .lng(nanumInfo.getLng())
                .location(nanumInfo.getLocation())
                .outfit(nanumInfo.getOutfit())
                .showId(nanum.getShow().getId())
                .providerId(nanum.getProvider().getId())
                .nanumDate(nanum.getNanumDate())
                .build();
    }

    public void setNanumImages(List<NanumImageDTO> nanumImages) {
        this.nanumImages = nanumImages;
    }

    public void setNanumTags(List<NanumTagDTO> nanumTags) {
        this.nanumTags = nanumTags;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
}
