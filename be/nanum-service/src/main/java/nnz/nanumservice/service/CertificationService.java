package nnz.nanumservice.service;

import nnz.nanumservice.entity.NanumStock;
import nnz.nanumservice.vo.NanumCertificationVO;

public interface CertificationService {

    void handleNanumCertification(Long nanumId, NanumCertificationVO nanumCertificationVO);

    NanumStock certifyQRCode(Long nanumId, Long receiveId);
}
