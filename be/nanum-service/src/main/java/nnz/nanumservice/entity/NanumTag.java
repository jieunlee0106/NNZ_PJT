package nnz.nanumservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.NanumTagDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "nanum_tags")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NanumTag extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id")
    private Tag tag;

//    @JsonSerialize(using = LocalDateTimeSerializer.class)
//    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
//    private LocalDateTime updatedAt;

    public static NanumTag of(NanumTagDTO nanumTagDTO, Nanum nanum, Tag tag) {
        return NanumTag.builder()
                .id(nanumTagDTO.getId())
                .nanum(nanum)
                .tag(tag)
//                .updatedAt(nanumTagDTO.getUpdatedAt())
                .build();
    }

    public void deleteNanumTag() {
        this.isDelete = true;
    }

    public void cancelDeleteNanumTag() {
        this.isDelete = false;
    }
}
