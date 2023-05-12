package nnz.nanumservice.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class CertificationDTO {
    private Long id;
    private String email;
    private String image;
}
