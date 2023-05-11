package nnz.nanumservice.dto.res.show;

import lombok.Getter;

@Getter
public class ResNanumDetailShowDTO {

    private Long id;

    private String title;

    public ResNanumDetailShowDTO(Long id, String title) {
        this.id = id;
        this.title = title;
    }
}
