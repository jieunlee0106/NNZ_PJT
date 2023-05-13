package nnz.userservice.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@Getter
public class ShowSyncVO {

    private Long id;
    private String title;
    private String location;
    private String startDate;
    private String endDate;
    private String ageLimit;
    private String posterImage;
    private Boolean isDelete;

    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;
}
