package nnz.nanumservice.service.impl;

import com.google.firebase.messaging.FirebaseMessagingException;
import io.github.eello.nnz.common.dto.PageDTO;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.*;
import nnz.nanumservice.dto.res.ResNanumStockDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDetailDTO;
import nnz.nanumservice.dto.res.nanum.ResSearchNanumDTO;
import nnz.nanumservice.dto.res.search.ResSearchDTO;
import nnz.nanumservice.dto.res.show.ResNanumDetailShowDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.dto.res.user.ResNanumWriterDTO;
import nnz.nanumservice.entity.*;
import nnz.nanumservice.exception.ErrorCode;
import nnz.nanumservice.repository.*;
import nnz.nanumservice.service.KafkaProducer;
import nnz.nanumservice.service.LocationDistance;
import nnz.nanumservice.service.NanumService;
import nnz.nanumservice.service.TagFeignClient;
import nnz.nanumservice.vo.NanumVO;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import java.util.*;
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
    private final EntityManager em;
    private final BookmarkRepository bookmarkRepository;
    private final NanumStockRepository nanumStockRepository;
    private final NanumImageService nanumImageService;
    private final FCMService fcmService;

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

        // todo: error handling
        List<TagDTO> tagDTOs = new ArrayList<>();
        data.getTags().forEach(tag -> {
            tagDTOs.add(new TagDTO(Long.toString(nanumDTO.getId()), tag, "nanum"));
        });

        // 태그 생성 요청
        List<TagDTO> createdTags = tagFeignClient.createTag(tagDTOs);
        // 서비스 db에 생성된 태그 저장
        List<Tag> tags = tagRepository.saveAll(
                createdTags.stream()
                        .map(Tag::of)
                        .collect(Collectors.toList())
        );

        // 나눔 태그 리스트 저장
        List<NanumTag> nanumTags = new ArrayList<>();
        for (Tag tag : tags) {
            NanumTag nanumTag = NanumTag.builder()
                    .nanum(nanum)
                    .tag(tag)
                    .build();
            nanumTags.add(nanumTag);
        }
        nanumTags = nanumTagRepository.saveAll(nanumTags);

        // 나눔 태그 dto 리스트
        List<NanumTagDTO> nanumTagDTOs = nanumTags.stream()
                .map(NanumTagDTO::of)
                .collect(Collectors.toList());

        List<NanumImageDTO> nanumImageDTOs = new ArrayList<>();
        nanumImageService.createNanumImage(nanum, nanumImageDTOs, nanumDTO, images);

        nanumDTO.setNanumTags(nanumTagDTOs);
        nanumDTO.setNanumImages(nanumImageDTOs);

        em.flush();

        KafkaMessage<NanumDTO> kafkaMessage = KafkaMessage.create().body(nanumDTO);
        producer.sendMessage(kafkaMessage, "nanum");
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

        // 즉시 나눔 가능 -> 무조건 진행중인 나눔만 조회
        List<Nanum> nanums = nanumRepository.findAllByStatus(2);
        List<NanumDTO> nanumDTOs = new ArrayList<>();
        for (Nanum nanum : nanums) {
            nanumDTOs.add(NanumDTO.of(nanum));
        }

        List<NearNanumDTO> nearNanumDTOs = new ArrayList<>();
        nanumDTOs.forEach(nanumDTO -> {
            if (nanumDTO.getLat() != null && nanumDTO.getLng() != null) {
                double lat2 = Double.parseDouble(nanumDTO.getLat());
                double lng2 = Double.parseDouble(nanumDTO.getLng());
                double distance = locationDistance.getDistance(lat, lng, lat2, lng2);
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
    public void createNanumInfo(Long nanumId, NanumInfoDTO nanumInfoDTO) throws FirebaseMessagingException {
        // todo : error handling
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();
        nanum.setNanumInfo(nanumInfoDTO);

        List<UserNanum> allByNanum = userNanumRepository.findAllByNanum(nanum);

        fcmService.sendMultipleMessage(
                "신청한 나눔에 당일 정보가 등록되었어요.",
                "지금 확인해보세요!",
                allByNanum.stream().map(userNanum -> userNanum.getReceiver().getDeviceToken()).collect(Collectors.toList()));
    }

    @Override
    public NanumInfoDTO readNanumInfo(Long nanumId, Long userId) {
        // todo : error handling
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();
        // 작성자 본인의 경우
        if (nanum.getProvider().getId() == userId) {
            return NanumInfoDTO.of(nanum, null);
        }
        User user = userRepository.findById(userId).orElseThrow();
        UserNanum userNanum = userNanumRepository.findByNanumAndReceiver(nanum, user).orElseThrow();
        return NanumInfoDTO.of(nanum, userNanum.getId());
    }

    @Override
    @Transactional
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
        Optional<Follower> follow = followerRepository.findByFollowingAndFollowerAndIsDeleteFalse(nanum.getProvider(), follower);

        // writer(나눠주는 사람) 정보 설정
        ResNanumWriterDTO writer = new ResNanumWriterDTO();
        writer.setWriterInfo(nanum.getProvider());
        if (follow.isPresent()) {
            // 팔로우 true 체크
            writer.setIsFollow(true);
        } //
        else {
            writer.setIsFollow(false);
        }
        resNanumDetailDTO.updateWriter(writer);

        // 예약 여부 확인
        Optional<UserNanum> userNanum = userNanumRepository.findByNanumAndReceiver(nanum, follower);
        if (userNanum.isPresent()) {
            resNanumDetailDTO.updateIsBooking(true);
        } //
        else {
            resNanumDetailDTO.updateIsBooking(false);
        }

        // 찜 여부 확인
        Optional<Bookmark> bookmark = bookmarkRepository.findByNanumAndUserAndIsDeleteFalse(nanum, follower);
        if (bookmark.isPresent()) {
            resNanumDetailDTO.updateIsBookmark(true);
        } //
        else {
            resNanumDetailDTO.updateIsBookmark(false);
        }

        nanum.plusViews();

        return resNanumDetailDTO;
    }

    @Override
    @Transactional
    public void createUserNanum(Long nanumId, Long userId, MultipartFile file) {
        //todo: error handling
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();
        User user = userRepository.findById(userId).orElseThrow();

        if(userNanumRepository.findByNanumAndReceiver(nanum, user).isPresent())
            throw new CustomException(ErrorCode.DUPLICATED_USER_NANUM);

        String image = null;
        if(nanum.getIsCertification()) {
            if(file == null) throw new CustomException(ErrorCode.USER_NANUM_NEED_CERTIFICATION);
            image = s3FileService.getS3Url(file);
        }

        UserNanum userNanum = UserNanum.builder()
                .nanum(nanum)
                .receiver(user)
                .certificationImage(image)
                .isReceived(false)
                .build();

        userNanumRepository.save(userNanum);

        UserNanumDTO userNanumDTO = UserNanumDTO.of(userNanum);
        KafkaMessage<UserNanumDTO> userNanumDTOKafkaMessage = KafkaMessage.create().body(userNanumDTO);
        producer.sendMessage(userNanumDTOKafkaMessage, "usernanum");
    }

    @Override
    public List<ResNanumDTO> readPopularNaums() {

        List<Nanum> nanums = nanumRepository.findAllByStatusLessThan(3);
        Map<Nanum, Double> popularMap = new HashMap<>();
        for (Nanum nanum : nanums) {
            List<Bookmark> bookmarks = bookmarkRepository.findAllByNanumAndIsDeleteFalse(nanum);
            popularMap.put(nanum, bookmarks.size() * 0.7 + nanum.getViews() * 0.3);
        }

        List<Nanum> keySet = new ArrayList<>(popularMap.keySet());
        keySet.sort((o1, o2) -> popularMap.get(o2).compareTo(popularMap.get(o1)));

        List<ResNanumDTO> resNanumDTOs = new ArrayList<>();
        if (keySet.size() > 8) {
            keySet.subList(0, 9).forEach(nanum -> {
                resNanumDTOs.add(ResNanumDTO.of(nanum));
            });
        } //
        else {
            keySet.forEach(nanum -> {
                resNanumDTOs.add(ResNanumDTO.of(nanum));
            });
        }

        return resNanumDTOs;
    }

    @Override
    public ResNanumStockDTO readNanumStock(Long nanumId) {

        // todo: error handling
        // 나눔이 있는지 먼저 유효성 검사
        Nanum nanum = nanumRepository.findById(nanumId).orElseThrow();
        NanumStock nanumStock = nanumStockRepository.findById(nanumId).orElseThrow();
        ResNanumStockDTO resNanumStockDTO = ResNanumStockDTO.of(nanum.getQuantity(), nanumStock.getStock());
        return resNanumStockDTO;
    }

    @Override
    @Transactional
    public void updateNanum(Long id, Long writerId, NanumVO data, List<MultipartFile> images) {

        // todo : error handling
        Nanum nanum = nanumRepository.findById(id).orElseThrow();

        // todo : error handling 사용자 불일치에 대한 예외처리 굳이 해야할까
        if (nanum.getProvider().getId() != writerId) {
            // throw new CustomException();
        }
        // 나눔 기본 정보 업데이트
        nanum.updateNanum(data);

        NanumDTO nanumDTO = NanumDTO.of(nanum);

        if (data.getTags() != null) {
            List<TagDTO> tagDTOs = new ArrayList<>();
            // 태그에 대한 수정 작업을 위해 태그 전부 삭제 후 수정된 태그 삽입
            nanum.getTags().forEach(nanumTag -> {
                nanumTag.deleteNanumTag();
            });

            data.getTags().forEach(tag -> {
                tagDTOs.add(new TagDTO(Long.toString(id), tag, "nanum"));
            });

            List<TagDTO> createdTags = tagFeignClient.createTag(tagDTOs);
            List<Tag> tags = tagRepository.saveAll(
                    createdTags.stream()
                            .map(Tag::of)
                            .collect(Collectors.toList())
            );

            // 새로운(수정된) 나눔 태그 리스트 저장
            List<NanumTag> nanumTags = new ArrayList<>();
            for (Tag tag : tags) {
                NanumTag nanumTag = NanumTag.builder()
                        .nanum(nanum)
                        .tag(tag)
                        .build();
                nanumTags.add(nanumTag);
            }

            nanumTags.forEach(nanumTag -> {
                Optional<NanumTag> findNanumTag = nanumTagRepository.findByNanumAndTag(nanum, nanumTag.getTag());
                if (findNanumTag.isPresent()) {
                    // 값이 이미 존재한다면 삭제 되돌리기
                    findNanumTag.get().cancelDeleteNanumTag();
                } //
                else {
                    // 값이 없다면 새로 저장
                    nanumTagRepository.save(nanumTag);
                }
            });

            // 나눔 태그 dto 리스트
            List<NanumTagDTO> nanumTagDTOs = nanumTags.stream()
                    .map(NanumTagDTO::of)
                    .collect(Collectors.toList());

            nanumDTO.setNanumTags(nanumTagDTOs);
        } //
        else {
            nanumDTO.setNanumTags(nanum.getTags().stream()
                    .map(NanumTagDTO::of)
                    .collect(Collectors.toList()));
        }

        if (images != null) {
            List<NanumImage> nanumImages = nanumImageRepository.findAllByNanum(nanum);
            nanumImages.forEach(nanumImage -> {
                nanumImage.deleteNanumImage();
            });

            List<NanumImageDTO> nanumImageDTOs = new ArrayList<>();
            nanumImageService.createNanumImage(nanum, nanumImageDTOs, nanumDTO, images);

            nanumDTO.setNanumImages(nanumImageDTOs);
        } //
        else {
            nanumDTO.setNanumImages(nanum.getThumbnails().stream()
                            .map(NanumImageDTO::of)
                            .collect(Collectors.toList()));
        }

        em.flush();

        KafkaMessage<NanumDTO> kafkaMessage = KafkaMessage.update().body(nanumDTO);
        producer.sendMessage(kafkaMessage, "nanum");
    }

    @Override
    public ResSearchDTO searchNanum(String query, Pageable pageable) {
        PageRequest pageRequest =
                PageRequest.of(
                        pageable.getPageNumber(), pageable.getPageSize(), Sort.by("createdAt").descending()
                );

        // 제목, 나눔이 속한 공연의 제목, 나눔에 속한 태그의 이름에 검색어가 포함된 나눔을 검색
        Page<Nanum> nanums = nanumRepository.findByQuery(query, pageRequest);
        // 관련 태그: 나눔에 속한 태그 중에 조회수가 높은 순으로 10개
        List<Tag> relatedTags = tagRepository.findByNanum(
                nanums.getContent(),
                PageRequest.of(0, 10, Sort.by("views").descending())
        );

        return ResSearchDTO.of(nanums, relatedTags);
    }
}
