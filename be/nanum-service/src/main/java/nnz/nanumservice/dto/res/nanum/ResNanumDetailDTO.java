package nnz.nanumservice.dto.res.nanum;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.res.show.ResNanumDetailShowDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.dto.res.user.ResNanumWriterDTO;
import nnz.nanumservice.entity.Nanum;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResNanumDetailDTO {

    private Long id;

    private String title;

    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate nanumDate;

    private String leftTime;

    private Boolean isCertification;

    private String condition;

    // 수량
    private Integer quantity;

    private String content;

    // 나눔 진행상태 = 나눔 전(0), 나눔 중(1), 마감(2), 종료(3)
    private Integer status;

    // 썸네일 이미지 주소
    private List<String> thumbnails;

    private List<ResTagDTO> tags;

    private ResNanumDetailShowDTO show;

    private ResNanumWriterDTO writer;

    // 찜 여부
    private boolean isBookmark;

    // 예약 여부
    private boolean isBooking;

    public static ResNanumDetailDTO of(Nanum nanum, List<String> thumbnails, List<ResTagDTO> tags, ResNanumDetailShowDTO show) {
        String leftTime = getCalculateLeftTime(nanum.getOpenTime());

        return ResNanumDetailDTO.builder()
                .id(nanum.getId())
                .title(nanum.getTitle())
                .nanumDate(nanum.getNanumDate())
                .leftTime(leftTime)
                .thumbnails(thumbnails)
                .tags(tags)
                .status(nanum.getStatus())
                .show(show)
                .isCertification(nanum.getIsCertification())
                .condition(nanum.getCondition())
                .content(nanum.getContent())
                .build();
    }

    private static String getCalculateLeftTime(LocalDateTime openTime) {
        LocalDateTime now = LocalDateTime.now();

        StringBuilder leftTime = new StringBuilder();
        Long hour = now.until(openTime, ChronoUnit.HOURS) % 12;
        Long minute = now.until(openTime, ChronoUnit.MINUTES) % 60;
        Long second = now.until(openTime, ChronoUnit.SECONDS) % 60;

        leftTime.append(now.until(openTime, ChronoUnit.DAYS)).append("일 ");
        leftTime.append(hour).append("시간 ");
        leftTime.append(minute).append("분 ");
        leftTime.append(second).append("초");

        return leftTime.toString();
    }

    public void updateWriter(ResNanumWriterDTO writer) {
        this.writer = writer;
    }

    public void updateIsBooking(boolean isBooking) {
        this.isBooking = isBooking;
    }

    public void updateIsBookmark(boolean isBookmark) {
        this.isBookmark = isBookmark;
    }
}
