package com.example.nnzcrawling.entity;

import com.example.nnzcrawling.dto.ShowTagDTO;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "show_tags")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShowTag extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show_id")
    Show show;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id")
    Tag tag;

//    @JsonSerialize(using = LocalDateTimeSerializer.class)
//    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
//    private LocalDateTime updatedAt;
//
//    protected boolean isDelete;

    public void setShow(Show show) {
        this.show = show;
    }

    public static ShowTag of(ShowTagDTO showTagDTO, Show show, Tag tag) {
        return ShowTag.builder()
                .id(showTagDTO.getId())
                .show(show)
                .tag(tag)
                .build();
    }
}
