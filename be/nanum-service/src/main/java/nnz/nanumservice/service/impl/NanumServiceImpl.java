package nnz.nanumservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.dto.PageDTO;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.*;
import nnz.nanumservice.dto.res.nanum.ResNanumDetailDTO;
import nnz.nanumservice.dto.res.show.ResNanumDetailShowDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.dto.res.user.ResNanumWriterDTO;
import nnz.nanumservice.entity.*;
import nnz.nanumservice.repository.*;
import nnz.nanumservice.service.KafkaProducer;
import nnz.nanumservice.service.LocationDistance;
import nnz.nanumservice.service.NanumService;
import nnz.nanumservice.service.TagFeignClient;
import nnz.nanumservice.vo.NanumVO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class NanumServiceImpl implements NanumService {

    private final NanumRepository nanumRepository;
    private final NanumImageRepository nanumImageRepository;
    private final UserRepository userRepository;
    private final ShowRepository showRepository;
    private final S3FileService s3FileService;
    private final TagFeignClient tagFeignClient;
    private final KafkaProducer producer;
    private final NanumTagRepository nanumTagRepository;
    private final TagRepository tagRepository;
    private final LocationDistance locationDistance;
    private final FollowerRepository followerRepository;
    private final UserNanumRepository userNanumRepository;

    // todo : status 바뀌는 로직 필요

    @Override
    @Transactional
    public void createNanum(NanumVO data, List<MultipartFile> images) {

        // todo : error handling
        User user = userRepository.findById(data.getWriter()).orElseThrow();
        Show show = showRepository.findById(data.getShowId()).orElseThrow();

        Nanum nanum = Nanum.voToEntity(data, user, show);
        // 썸네일 설정은 나눔 등록을 먼저 해준 후에 한다.
        // -> 나눔 이미지 엔티티에 Show 객체 필요하기 때문.
        nanum = nanumRepository.save(nanum);
        NanumDTO nanumDTO = NanumDTO.of(nanum);

        KafkaMessage<NanumDTO> nanumDTOKafkaMessage = KafkaMessage.create().body(nanumDTO);
        producer.sendMessage(nanumDTOKafkaMessage, "dev-nanum");

        // todo: error handling
        List<TagDTO> tagDTOs = new ArrayList<>();
        data.getTags().forEach(tag -> {
            tagDTOs.add(new TagDTO(Long.toString(nanumDTO.getId()), tag, "nanum"));
        });

        tagFeignClient.createTag(tagDTOs);

        Boolean isThumbnail = true;

        for (MultipartFile image : images) {
            String path = s3FileService.getS3Url(image);
            String originalName = image.getOriginalFilename();

            NanumImage nanumImage = NanumImage.builder()
                    .path(path)
                    .originalName(originalName)
                    .isThumbnail(isThumbnail)
                    .nanum(nanum)
                    .build();
            nanumImageRepository.save(nanumImage);

            NanumImageDTO nanumImageDTO = NanumImageDTO.of(nanumImage);

            KafkaMessage<NanumImageDTO> nanumImageDTOKafkaMessage = KafkaMessage.create().body(nanumImageDTO);
            producer.sendMessage(nanumImageDTOKafkaMessage, "dev-nanumimage");

            if (isThumbnail) {
                nanum.updateThumbnail(path);
            }
            isThumbnail = false;
        }
    }

    @Override
    public PageDTO readNanumsByShowId(Long showId, PageRequest pageRequest) {

        // todo : error handling
        Show show = showRepository.findById(showId).orElseThrow();
        Page<Nanum> nanumPage = nanumRepository.findByShowAndIsDeleteFalse(show, pageRequest);

        Page<NanumDTO> nanumDTOPage = nanumPage.map(NanumDTO::of);
        return PageDTO.of(nanumDTOPage);
    }

    @Override
    public PageDTO readNanumsByNanumTag(String nanumTagName, PageRequest pageRequest) {

        // todo: error handling
        Tag tag = tagRepository.findByTag(nanumTagName).orElseThrow();
        List<NanumTag> nanumTags = nanumTagRepository.findAllByTag(tag);

        List<Nanum> nanums = new ArrayList<>();
        nanumTags.forEach(nanumTag -> {
            nanums.add(nanumTag.getNanum());
        });

        int start = (int) pageRequest.getOffset();
        int end = Math.min((start + pageRequest.getPageSize()), nanums.size());
        Page<Nanum> nanumPage = new PageImpl<>(nanums.subList(start, end), pageRequest, nanums.size());

        Page<NanumDTO> nanumDTOPage = nanumPage.map(NanumDTO::of);
        return PageDTO.of(nanumDTOPage);
    }

    @Override
    public PageDTO readNanumsByLocation(Double lat, Double lng, PageRequest pageRequest) {

        List<Nanum> nanums = nanumRepository.findAllByStatus(1);
        List<NanumDTO> nanumDTOs = new ArrayList<>();
        for (Nanum nanum : nanums) {
            nanumDTOs.add(NanumDTO.of(nanum));
        }

        List<NearNanumDTO> nearNanumDTOs = new ArrayList<>();
        nanumDTOs.forEach(nanumDTO -> {
            if (nanumDTO.getLat() != null && nanumDTO.getLng() != null) {
                double distance = locationDistance.getDistance(lat, lng, nanumDTO.getLat(), nanumDTO.getLng());
                if (distance <= 10.0 && nearNanumDTOs.size() <= 8) {
                    nearNanumDTOs.add(new NearNanumDTO(distance, nanumDTO));
                }
            }
        });

        nanumDTOs = new ArrayList<>();

        if (!nearNanumDTOs.isEmpty()) {
            Collections.sort(nearNanumDTOs);

            for (NearNanumDTO nearNanumDTO : nearNanumDTOs) {
                nanumDTOs.add(nearNanumDTO.getNanumDTO());
            }

            int start = (int) pageRequest.getOffset();
            int end = Math.min((start + pageRequest.getPageSize()), nanumDTOs.size());
            Page<NanumDTO> nanumDTOPage = new PageImpl<>(nanumDTOs.subList(start, end), pageRequest, nanumDTOs.size());

            return PageDTO.of(nanumDTOPage);
        } //
        else {
            Page<NanumDTO> nanumDTOPage = new PageImpl<>(nanumDTOs.subList(0, 0), pageRequest, nanumDTOs.size());
            return PageDTO.of(nanumDTOPage);
        }
    }

    @Override
    @Transactional
    public void createNanumInfo(Long nanumId, NanumInfoDTO nanumInfoDTO) {
        // todo : error handling
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();
        nanum.setNanumInfo(nanumInfoDTO);
    }

    @Override
    public NanumInfoDTO readNanumInfo(Long nanumId) {
        // todo : error handling
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();
        return NanumInfoDTO.of(nanum);
    }

    @Override
    public ResNanumDetailDTO readNanumDetail(Long nanumId, Long userId) {
        // todo : error handling
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();

        // 썸네일 목록 구하기
        List<String> thumbnails = new ArrayList<>();
        nanum.getThumbnails().forEach(nanumImage -> {
            thumbnails.add(nanumImage.getPath());
        });

        // 태그 목록 구하기
        List<ResTagDTO> tags = new ArrayList<>();
        nanum.getTags().forEach(nanumTag -> {
            // todo : error handling
            Tag tag = tagRepository.findById(nanumTag.getTag().getId()).orElseThrow();
            tags.add(new ResTagDTO(tag.getId(), tag.getTag()));
        });

        // 공연 정보 구하기
        ResNanumDetailShowDTO show =
                new ResNanumDetailShowDTO(nanum.getShow().getId(), nanum.getShow().getTitle());

        // DTO 변환
        ResNanumDetailDTO resNanumDetailDTO = ResNanumDetailDTO.of(nanum, thumbnails, tags, show);

        User follower = userRepository.findById(userId).orElseThrow();
        Optional<Follower> follow = followerRepository.findByFollowingAndFollower(nanum.getProvider(), follower);

        // writer(나눠주는 사람) 정보 설정
        ResNanumWriterDTO writer = new ResNanumWriterDTO();
        writer.setWriterInfo(nanum.getProvider());
        if (follow.isPresent()) {
            // 팔로우 true 체크
            writer.setIsFollow(true);

            // todo: 트위터 true 체크

        } //
        else {
            writer.setIsFollow(false);
        }
        resNanumDetailDTO.setWriter(writer);

        // 예약 여부 확인
        Optional<UserNanum> userNanum = userNanumRepository.findByReceiver(follower);
        if (userNanum.isPresent()) {
            resNanumDetailDTO.setIsBooking(true);
        } //
        else {
            resNanumDetailDTO.setIsBooking(false);
        }

        return resNanumDetailDTO;
    }
}
