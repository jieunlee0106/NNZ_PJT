package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "receive_nanums")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ReceiveNanum extends BaseEntity {

    @Id
    private Long id;

    private boolean isCertificated;
    private boolean isReceived;


    @ManyToOne
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    private User receiver;
}
