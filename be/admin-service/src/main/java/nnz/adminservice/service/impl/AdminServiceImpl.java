package nnz.adminservice.service.impl;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.adminservice.dto.*;
import nnz.adminservice.dto.kafka.ShowKafkaDTO;
import nnz.adminservice.entity.*;
import nnz.adminservice.exception.ErrorCode;
import nnz.adminservice.repository.*;
import nnz.adminservice.service.AdminService;
import nnz.adminservice.service.KafkaProducer;
import nnz.adminservice.service.TagFeignClient;
import nnz.adminservice.vo.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.ArrayList;
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
    private final CategoryRepository categoryRepository;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final AmazonS3 amazonS3;
    private final KafkaProducer kafkaProducer;
    private final TagFeignClient tagFeignClient;
    @Override
    public List<AskedShowDTO> findAskedShowList() {

        List<AskedShow> allByStatus = askedShowRepository.findAllByStatus(AskedShow.AskedShowStatus.WAIT);

        return allByStatus.stream().map(askedShow -> AskedShowDTO.builder()
                .id(askedShow.getId())
                .requester(userRepository.findById(askedShow.getCreatedBy())
                        .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND)).getNickname())
                .title(askedShow.getTitle())
                .path(askedShow.getPath())
                .status(askedShow.getStatus().getCode())
                .build()).collect(Collectors.toList());
    }

    @Override
    public void handleAskedShow(AskedShowStatusVO askedShowStatusVO) throws JsonProcessingException {

        AskedShow askedShow = askedShowRepository.findById(askedShowStatusVO.getId())
                .orElseThrow(() -> new CustomException(ErrorCode.ASKED_SHOW_NOT_FOUND));

        // 승인할 시
        if(askedShowStatusVO.getStatus() == 1){
            // asked_shows 테이블 상태 변경
            askedShow.updateStatus(1);
        }
        // 거부할 시
        else if(askedShowStatusVO.getStatus() == 2){
            // asked_shows 테이블 상태 변경
            askedShow.updateStatus(2);
        }
    }

    @Override
    public void createShow(ShowVO showVO, MultipartFile file) {

        Category category = categoryRepository.findByCode(showVO.getCategory())
                .orElseThrow(() -> new CustomException(ErrorCode.CATEGORY_NOT_FOUND));

        try{
            String originalName = file.getOriginalFilename();
            String savedName = UUID.randomUUID() + "-" + originalName;

            ObjectMetadata objMeta = new ObjectMetadata();
            objMeta.setContentLength(file.getSize());
            objMeta.setContentType(file.getContentType());

            amazonS3.putObject(bucket, savedName, file.getInputStream(), objMeta);

            String path = amazonS3.getUrl(bucket, savedName).toString();

            Show save = showRepository.save(Show.builder()
                    .category(category)
                    .posterImage(path)
                    .title(showVO.getTitle())
                    .startDate(showVO.getStartDate())
                    .endDate(showVO.getEndDate())
                    .location(showVO.getLocation())
                    .ageLimit(showVO.getAgeLimit())
                    .region(showVO.getRegion())
                    .build());

            // Kafka에 메세지 전송
            ShowKafkaDTO showKafkaDTO = ShowKafkaDTO.entityToDTO(save);

            KafkaMessage<ShowKafkaDTO> message = KafkaMessage.create().body(showKafkaDTO);

            kafkaProducer.sendMessage(message, "show");


            // 태그 생성
            List<TagVO> tagVOList = new ArrayList<>();

            // 지역 태그 추가
            tagVOList.add(TagVO.builder()
                    .title(save.getTitle())
                    .tag(save.getRegion())
                    .type("show")
                    .build());

            // 카테고리 태그 추가
            tagVOList.add(TagVO.builder()
                    .title(save.getTitle())
                    .tag(save.getCategory().getName())
                    .type("show")
                    .build());

            tagFeignClient.createTag(tagVOList);

        }catch (Exception e){
            e.printStackTrace();
            throw new CustomException(ErrorCode.FILE_UPLOAD_FAIL);
        }
    }

    @Override
    public List<ReportDTO> findReportList() {
        List<Report> allByStatus = reportRepository.findAllByStatus(Report.ReportStatus.WAIT);

        return allByStatus.stream().map(
                report -> ReportDTO.builder()
                        .id(report.getId())
                        .reportedAt(report.getReportedAt())
                        .reporterId(report.getReporter().getId())
                        .targetId(report.getTarget().getId())
                        .reason(report.getReason())
                        .status(report.getStatus().getCode())
                        .build()).collect(Collectors.toList());
    }

    @Override
    public void handleReport(ReportStatusVO reportStatusVO) throws JsonProcessingException {
        Report report = reportRepository.findById(reportStatusVO.getId())
                .orElseThrow(() -> new CustomException(ErrorCode.REPORT_NOT_FOUND));

        // 승인할 시
        if(reportStatusVO.getStatus() == 1){
            report.updateStatus(1);
        }
        // 거부할 시
        else if(reportStatusVO.getStatus() == 2){
            report.updateStatus(2);
        }

        report.updateProcessedAt(LocalDateTime.now());
    }

    @Override
    public void registBanners(List<MultipartFile> files, BannerVO bannerVO) throws JsonProcessingException {
        List<BannerKafkaDTO> bannerDTOList = new ArrayList<>();

        for(int i=0; i<3; i++){
            Banner banner = null;
            try{
                MultipartFile file = files.get(i);
                Long showId = Long.parseLong(bannerVO.getShowIds().get(i));

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

                    banner = bannerRepository.save(Banner.builder()
                            .image(path)
                            .show(show)
                            .build());

                }catch (Exception e){
                    throw new CustomException(ErrorCode.FILE_UPLOAD_FAIL);
                }
            }catch (NullPointerException e){
                throw new CustomException(ErrorCode.FILE_NOT_ENOUGH);
            }
            bannerDTOList.add(BannerKafkaDTO.toDTO(banner));
        }
        KafkaMessage<List<BannerKafkaDTO>> message = KafkaMessage.create().body(bannerDTOList);

        kafkaProducer.sendMessage(message, "banner");
    }
}
