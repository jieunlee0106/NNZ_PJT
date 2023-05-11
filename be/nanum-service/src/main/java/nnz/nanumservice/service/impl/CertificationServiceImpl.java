package nnz.nanumservice.service.impl;

import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.ErrorCode;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.UserNanum;
import nnz.nanumservice.repository.NanumRepository;
import nnz.nanumservice.repository.UserNanumRepository;
import nnz.nanumservice.repository.UserRepository;
import nnz.nanumservice.service.CertificationService;
import nnz.nanumservice.vo.NanumCertificationVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class CertificationServiceImpl implements CertificationService {

    private final NanumRepository nanumRepository;
    private final UserRepository userRepository;
    private final UserNanumRepository userNanumRepository;

    @Override
    public void handleNanumCertification(Long nanumId, NanumCertificationVO nanumCertificationVO) {
        Nanum nanum = nanumRepository.findById(nanumId)
                .orElseThrow(() -> new CustomException(ErrorCode.NANUM_NOT_FOUND));

        UserNanum userNanum = userNanumRepository.findById(nanumCertificationVO.getId())
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NANUM_NOT_FOUND));

        // 이미 처리한 인증인지 확인
        if(userNanum.getIsCertificated() != null) throw new CustomException(ErrorCode.ALREADY_USER_NANUM);

        // true : 인증 성공, false : 인증 실패
        userNanum.updateIsCertificated(nanumCertificationVO.getCertification());
    }
}
