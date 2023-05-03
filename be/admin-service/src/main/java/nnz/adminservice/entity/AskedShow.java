package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Table(name = "asked_shows")
@Getter
public class AskedShow extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String path;

    @Enumerated(EnumType.STRING)
    private AskedShowStatus status;

    @Getter
    @RequiredArgsConstructor
    public enum AskedShowStatus {
        WAIT(0),
        ACCEPT(1),
        REFUSE(2);

        private final int code;
    }
}
