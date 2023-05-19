package nnz.nanumservice.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.Nanum;

import java.time.LocalDateTime;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class NanumInfoDTO {

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime nanumTime;

    private String location;

    private Double lat;

    private Double lng;

    private String outfit;

    // user nanum entity ID : QR 인증을 위해 넘겨주는 값
    private Long receiveId;

    public static NanumInfoDTO of(Nanum nanum, Long id) {
        return NanumInfoDTO.builder()
                .nanumTime(nanum.getNanumInfo().getNanumTime())
                .location(nanum.getNanumInfo().getLocation())
                .lat(nanum.getNanumInfo().getLat())
                .lng(nanum.getNanumInfo().getLng())
                .outfit(nanum.getNanumInfo().getOutfit())
                .receiveId(id)
                .build();
    }
}
