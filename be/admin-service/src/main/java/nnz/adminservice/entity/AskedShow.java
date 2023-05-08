package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Entity
@NoArgsConstructor
@Table(name = "asked_shows")
@Getter
@SQLDelete(sql = "UPDATE AskedShow SET is_delete = 1 WHERE id = ?")
@Where(clause = "is_delete  = 0")
public class AskedShow extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String path;

    @Enumerated(EnumType.ORDINAL)
    private AskedShowStatus status;

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
