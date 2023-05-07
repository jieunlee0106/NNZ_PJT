package nnz.adminservice.service.impl;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.adminservice.dto.AskedShowDTO;
import nnz.adminservice.dto.ReportDTO;
import nnz.adminservice.entity.AskedShow;
import nnz.adminservice.entity.Banner;
import nnz.adminservice.entity.Report;
import nnz.adminservice.entity.Show;
import nnz.adminservice.exception.ErrorCode;
import nnz.adminservice.repository.*;
import nnz.adminservice.service.AdminService;
import nnz.adminservice.vo.AskedShowStatusVO;
import nnz.adminservice.vo.ReportStatusVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class AdminServiceImpl implements AdminService {
    private final AskedShowRepository askedShowRepository;
    private final UserRepository userRepository;
    private final ReportRepository reportRepository;
    private final BannerRepository bannerRepository;
    private final ShowRepository showRepository;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final AmazonS3 amazonS3;

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

    @Override
    public void handleReport(ReportStatusVO reportStatusVO) {
        Report report = reportRepository.findById(reportStatusVO.getReportId())
                .orElseThrow(() -> new CustomException(ErrorCode.REPORT_NOT_FOUND));

        // 승인할 시
        if(reportStatusVO.getStatus() == 1){
            report.updateStatus(1);
        }
        // 거부할 시
        else if(reportStatusVO.getStatus() == 2){
            report.updateStatus(2);
        }
    }

    @Override
    public void registBanners(List<MultipartFile> files, List<Long> showIDsVO) {

        for(int i=0; i<3; i++){
            try{
                MultipartFile file = files.get(i);
                Long showId = showIDsVO.get(i);

                Show show = showRepository.findById(showId)
                        .orElseThrow(() -> new CustomException(ErrorCode.SHOW_NOT_FOUND));

                try{
                    String originalName = file.getOriginalFilename();
                    String savedName = UUID.randomUUID() + "-" + originalName;

                    ObjectMetadata objMeta = new ObjectMetadata();
                    objMeta.setContentLength(file.getSize());
                    objMeta.setContentType(file.getContentType());

                    amazonS3.putObject(bucket, savedName, file.getInputStream(), objMeta);

                    String path = amazonS3.getUrl(bucket, savedName).toString();

                    bannerRepository.save(Banner.builder()
                            .image(path)
                            .show(show)
                            .build());

                }catch (Exception e){
                    throw new CustomException(ErrorCode.FILE_UPLOAD_FAIL);
                }
            }catch (NullPointerException e){
                throw new CustomException(ErrorCode.FILE_NOT_ENOUGH);
            }
        }
    }
}
