package nnz.userservice.vo.sync;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@Getter
public class NanumSyncVO {

    private Long id;
    private Long providerId;
    private Long showId;
    private String title;
    private String thumbnail;

    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate date;
    private String location;
    private Boolean isCertification;
    private Integer status;
    private List<NanumTagSyncVO> nanumTags;

    @NoArgsConstructor
    @Getter
    public static class NanumTagSyncVO {
        private Long id;
        private TagSyncVo tag;

        @JsonDeserialize(using = LocalDateTimeDeserializer.class)
        private LocalDateTime updatedAt;
    }

    @NoArgsConstructor
    @Getter
    public static class TagSyncVo {
        String tag;
    }
}
