package nnz.nanumservice.service;

import nnz.nanumservice.vo.NanumCertificationVO;

public interface CertificationService {

    void handleNanumCertification(Long nanumId, NanumCertificationVO nanumCertificationVO);
}
