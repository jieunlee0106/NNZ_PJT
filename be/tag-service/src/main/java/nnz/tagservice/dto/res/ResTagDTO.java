package nnz.tagservice.dto.res;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.tagservice.entity.Tag;

import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResTagDTO implements Serializable {

    private Long id;

    private String tag;

    public static ResTagDTO of(Tag tag) {
        return ResTagDTO.builder()
                .id(tag.getId())
                .tag(tag.getTag())
                .build();
    }
}
