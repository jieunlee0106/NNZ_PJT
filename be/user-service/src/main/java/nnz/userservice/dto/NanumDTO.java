package nnz.userservice.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.Nanum;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
public class NanumDTO {

    private String thumbnail;
    private String title;
    private LocalDate date;
    private String location;
    private Boolean isCertification;
    private int status;

    public static NanumDTO of(Nanum nanum) {
        NanumDTO dto = new NanumDTO();
        dto.thumbnail = nanum.getThumbnail();
        dto.title = nanum.getTitle();
        dto.date = nanum.getDate();
        dto.location = nanum.getLocation();
        dto.isCertification = nanum.isCertification();
        dto.status = nanum.getStatus().getStatus();
        return dto;
    }

}
