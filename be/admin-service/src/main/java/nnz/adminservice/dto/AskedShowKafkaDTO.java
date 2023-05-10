package nnz.adminservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AskedShowKafkaDTO {
    private String title;
    private String path;
    private int status;
    private Long createdBy;
}
