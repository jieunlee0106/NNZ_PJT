package nnz.adminservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.*;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Entity
@NoArgsConstructor
@Table(name = "asked_shows")
@Getter
@Builder
@AllArgsConstructor
@SQLDelete(sql = "UPDATE AskedShow SET is_delete = 1 WHERE id = ?")
@Where(clause = "is_delete  = 0")
public class AskedShow {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String path;

    @Enumerated(EnumType.ORDINAL)
    private AskedShowStatus status;

    @CreatedBy
    private Long createdBy;

    @CreatedDate
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime createdAt;

    @LastModifiedBy
    private Long updatedBy;

    @LastModifiedDate
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    protected boolean isDelete;

    @Getter
    @RequiredArgsConstructor
    public enum AskedShowStatus {
        WAIT(0),
        ACCEPT(1),
        REFUSE(2);

        private final int code;

        private static final Map<Integer, String> CODE_MAP = Collections.unmodifiableMap(
                Stream.of(values()).collect(Collectors.toMap(AskedShowStatus::getCode, AskedShowStatus::name))
        );

        public static AskedShowStatus of(final int code){
            return AskedShowStatus.valueOf(CODE_MAP.get(code));
        }
    }

    public void updateStatus(int code){
        this.status = AskedShowStatus.of(code);
    }

}
