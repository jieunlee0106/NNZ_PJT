package nnz.adminservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.entity.AskedShow;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AskedShowDTO {
    private Long id;
    private String requester;
    private String title;
    private String path;
    private int status;

}
