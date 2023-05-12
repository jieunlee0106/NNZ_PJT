package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.adminservice.dto.kafka.NanumTagKafkaDTO;

import javax.persistence.*;

@Entity
@Table(name = "nanum_tags")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NanumTag extends BaseEntity {

    @Id
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id")
    private Tag tag;

    public static NanumTag of(NanumTagKafkaDTO dto, Nanum nanum, Tag tag) {
        return NanumTag.builder()
                .id(dto.getId())
                .nanum(nanum)
                .tag(tag)
//                .updatedAt(nanumTagDTO.getUpdatedAt())
                .build();
    }
}

