package nnz.nanumservice.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.Getter;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Getter
public class NanumVO {

    private Long showId;

    private Long writer;

    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate nanumDate;

    private String condition;

    private String title;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime openTime;

    private Boolean isCertification;

    private Integer quantity;

    private String content;

    private List<String> tags;

    public void decode() {
        this.condition = new String(Base64.getDecoder().decode(this.condition.getBytes(StandardCharsets.UTF_8)));
        this.title = new String(Base64.getDecoder().decode(this.title.getBytes(StandardCharsets.UTF_8)));
        this.content = new String(Base64.getDecoder().decode(this.content.getBytes(StandardCharsets.UTF_8)));

        List<String> tags = new ArrayList<>();
        for (String tag : this.tags) {
            tags.add(new String(Base64.getDecoder().decode(tag.getBytes(StandardCharsets.UTF_8))));
        }
        this.tags = tags;
    }
}
