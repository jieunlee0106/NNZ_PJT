package nnz.nanumservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.entity.NanumImage;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NanumImageDTO {

    private Long id;

    private String path;

    private String originalName;

    private Boolean isThumbnail;

    private Long nanumId;

    public static NanumImageDTO of(NanumImage nanumImage) {
        return NanumImageDTO.builder()
                .id(nanumImage.getId())
                .path(nanumImage.getPath())
                .originalName(nanumImage.getOriginalName())
                .isThumbnail(nanumImage.getIsThumbnail())
                .nanumId(nanumImage.getNanum().getId())
                .build();
    }
}
