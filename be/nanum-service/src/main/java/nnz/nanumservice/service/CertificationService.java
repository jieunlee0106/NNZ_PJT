package nnz.nanumservice.service;

import com.google.firebase.messaging.FirebaseMessagingException;
import nnz.nanumservice.dto.CertificationDTO;
import nnz.nanumservice.entity.NanumStock;
import nnz.nanumservice.vo.NanumCertificationVO;

import java.util.List;

public interface CertificationService {

    void handleNanumCertification(Long nanumId, NanumCertificationVO nanumCertificationVO) throws FirebaseMessagingException;

    NanumStock certifyQRCode(Long nanumId, Long receiveId);

    List<CertificationDTO> findCertificationList(Long nanumId);
}
