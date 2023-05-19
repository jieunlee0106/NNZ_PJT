package nnz.adminservice.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class TagVO {

    private String title;

    private String tag;

    private String type;
}

