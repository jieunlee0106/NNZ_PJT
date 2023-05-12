package nnz.nanumservice.service;

import nnz.nanumservice.dto.CertificationDTO;
import nnz.nanumservice.entity.NanumStock;
import nnz.nanumservice.vo.NanumCertificationVO;

import java.util.List;

public interface CertificationService {

    void handleNanumCertification(Long nanumId, NanumCertificationVO nanumCertificationVO);

    NanumStock certifyQRCode(Long nanumId, Long receiveId);

    List<CertificationDTO> findCertificationList(Long nanumId);
}
