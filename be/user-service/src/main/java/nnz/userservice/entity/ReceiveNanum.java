package nnz.userservice.entity;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "receive_nanums")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@ToString
public class ReceiveNanum {

    @Id
    private Long id;

    private boolean isCertificated;
    private boolean isReceived;
    private LocalDateTime updatedAt;
    private boolean isDelete;


    @ManyToOne
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    private User receiver;

    public ReceiveNanum updateIsCertificated(boolean isCertificated) {
        this.isCertificated = isCertificated;
        return this;
    }

    public ReceiveNanum updateIsReceived(boolean isReceived) {
        this.isReceived = isReceived;
        return this;
    }

    public void update(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
