package nnz.adminservice.dto;

import lombok.Builder;
import lombok.Getter;
import nnz.adminservice.entity.AskedShow;

@Getter
@Builder
public class AskedShowDTO {
    private String requester;
    private String title;
    private String path;
}
