package nnz.nanumservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.UserNanum;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserNanumDTO {

    private Long id;

    private Boolean isCertificated;

    private Boolean isReceived;

    private Long userId;

    private Long nanumId;

    private String certificationImage;

    public static UserNanumDTO of(UserNanum userNanum) {
        return UserNanumDTO.builder()
                .id(userNanum.getId())
                .isCertificated(userNanum.getIsCertificated())
                .isReceived(userNanum.getIsReceived())
                .userId(userNanum.getReceiver().getId())
                .nanumId(userNanum.getNanum().getId())
                .certificationImage(userNanum.getCertificationImage())
                .build();
    }
}
