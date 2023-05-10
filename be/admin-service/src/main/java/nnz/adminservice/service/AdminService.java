package nnz.adminservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.adminservice.dto.AskedShowDTO;
import nnz.adminservice.dto.ReportDTO;
import nnz.adminservice.vo.AskedShowStatusVO;
import nnz.adminservice.vo.ReportStatusVO;
import nnz.adminservice.vo.ShowVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface AdminService {
    List<AskedShowDTO> findAskedShowList();

    void handleAskedShow(AskedShowStatusVO askedShowStatusVO) throws JsonProcessingException;

    List<ReportDTO> findReportList();

    void handleReport(ReportStatusVO reportStatusVO) throws JsonProcessingException;

    void registBanners(List<MultipartFile> files, List<String> showIDsVO) throws JsonProcessingException;

    void createShow(ShowVO showVO, MultipartFile file);
}
