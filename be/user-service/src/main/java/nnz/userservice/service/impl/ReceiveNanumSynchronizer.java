package nnz.userservice.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.ReceiveNanum;
import nnz.userservice.entity.User;
import nnz.userservice.repository.NanumRepository;
import nnz.userservice.repository.ReceiveNanumRepository;
import nnz.userservice.repository.UserRepository;
import nnz.userservice.service.DBSynchronizer;
import nnz.userservice.vo.sync.ReceiveNanumSyncVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class ReceiveNanumSynchronizer implements DBSynchronizer<ReceiveNanumSyncVO> {

    private final UserRepository userRepository;
    private final NanumRepository nanumRepository;
    private final ReceiveNanumRepository receiveNanumRepository;

    @Override
    public void create(ReceiveNanumSyncVO vo) {
        log.info("ReceiveNanum Create: Nanum id: {} -> give -> Receiver id: {}", vo.getNanumId(), vo.getUserId());
        if (vo.getNanumId() == null) {
            log.warn("ReceiveNanum Create Fail -> Nanum id is null");
            return;
        }

        if (vo.getUserId() == null) {
            log.warn("ReceiveNanum Create Fail -> Receiver id is null");
            return;
        }

        Optional<Nanum> optNanum = nanumRepository.findById(vo.getNanumId());
        if (optNanum.isEmpty()) {
            log.warn("ReceiveNanum Create Fail -> nanum does not exists.");
            return;
        }
        Nanum nanum = optNanum.get();

        Optional<User> optReceiver = userRepository.findById(vo.getUserId());
        if (optReceiver.isEmpty()) {
            log.warn("ReceiverNanum Create Fail -> receiver does not exists.");
            return;
        }
        User receiver = optReceiver.get();

        ReceiveNanum receiveNanum = ReceiveNanum.builder()
                .id(vo.getId())
                .isCertificated(vo.getIsCertificated() != null && vo.getIsCertificated())
                .isReceived(vo.getIsReceived())
                .nanum(nanum)
                .receiver(receiver)
                .build();

        receiveNanumRepository.save(receiveNanum);
        log.info("ReceiveNanum Create Success: 참여한 나눔: {}", receiveNanum);
    }

    @Override
    public void update(ReceiveNanumSyncVO vo) {
        log.info("ReceiveNanum Update: Nanum id: {} -> give -> Receiver id: {}", vo.getNanumId(), vo.getIsReceived());

        Optional<ReceiveNanum> optReceiveNanum =
                receiveNanumRepository.findById(vo.getId());
        if (optReceiveNanum.isEmpty()) {
//            log.warn("ReceiveNanum Update Fail: 참여한 나눔 id: {} -> ReceiveNanum NotFound", vo.getId());
            create(vo);
            return;
        }

        ReceiveNanum receiveNanum = optReceiveNanum.get();
        receiveNanum
                .updateIsReceived(vo.getIsReceived())
                .updateIsCertificated(vo.getIsCertificated() != null && vo.getIsCertificated())
                .update(vo.getUpdatedAt());

        log.info("ReceiveNanum Update Success: 참여한 나눔: {}", receiveNanum);
    }

    @Override
    public void delete(ReceiveNanumSyncVO vo) {

    }
}
