package nnz.adminservice.service;

import nnz.adminservice.dto.AskedShowDTO;
import nnz.adminservice.dto.ReportDTO;
import nnz.adminservice.vo.AskedShowStatusVO;

import java.util.List;

public interface AdminService {
    List<AskedShowDTO> findAskedShowList();

    void handleAskedShow(AskedShowStatusVO askedShowStatusVO);

    List<ReportDTO> findReportList();
}
