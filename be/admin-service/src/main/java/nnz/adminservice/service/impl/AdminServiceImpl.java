package nnz.adminservice.service.impl;

import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import nnz.adminservice.dto.AskedShowDTO;
import nnz.adminservice.dto.ReportDTO;
import nnz.adminservice.entity.AskedShow;
import nnz.adminservice.entity.Report;
import nnz.adminservice.exception.ErrorCode;
import nnz.adminservice.repository.AskedShowRepository;
import nnz.adminservice.repository.ReportRepository;
import nnz.adminservice.repository.UserRepository;
import nnz.adminservice.service.AdminService;
import nnz.adminservice.vo.AskedShowStatusVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
    private final AskedShowRepository askedShowRepository;
    private final UserRepository userRepository;
    private final ReportRepository reportRepository;
    @Override
    public List<AskedShowDTO> findAskedShowList() {

        List<AskedShow> allByStatus = askedShowRepository.findAllByStatus(AskedShow.AskedShowStatus.WAIT);

        return allByStatus.stream().map(askedShow -> AskedShowDTO.builder()
                .requester(userRepository.findById(askedShow.getCreatedBy())
                        .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND)).getNickname())
                .title(askedShow.getTitle())
                .path(askedShow.getPath())
                .build()).collect(Collectors.toList());
    }

    @Override
    public void handleAskedShow(AskedShowStatusVO askedShowStatusVO) {

        AskedShow askedShow = askedShowRepository.findById(askedShowStatusVO.getAskedShowsId())
                .orElseThrow(() -> new CustomException(ErrorCode.ASKED_SHOW_NOT_FOUND));

        // 승인할 시
        if(askedShowStatusVO.getAskedShowStatus() == 1){
            // shows 테이블에 insert
            // show에 뭘 insert하지?

            // asked_shows 테이블 상태 변경
            askedShow.updateStatus(1);
        }
        // 거부할 시
        else if(askedShowStatusVO.getAskedShowStatus() == 2){
            // asked_shows 테이블 상태 변경
            askedShow.updateStatus(2);
        }

    }

    @Override
    public List<ReportDTO> findReportList() {
        List<Report> allByStatus = reportRepository.findAllByStatus(Report.ReportStatus.WAIT);

        return allByStatus.stream().map(
                report -> ReportDTO.builder()
                        .reportedAt(report.getReportedAt())
                        .reportedId(report.getReporter().getId())
                        .targetId(report.getTarget().getId())
                        .reason(report.getReason())
                        .status(report.getStatus().getCode())
                        .build()).collect(Collectors.toList());
    }
}
