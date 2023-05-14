package nnz.nanumservice.service.impl;

import io.github.eello.nnz.common.dto.PageDTO;
import io.github.eello.nnz.common.exception.CustomException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.*;
import nnz.nanumservice.dto.res.ResNanumStockDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDetailDTO;
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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
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

//        KafkaMessage<NanumDTO> nanumDTOKafkaMessage = KafkaMessage.create().body(nanumDTO);
//        producer.sendMessage(nanumDTOKafkaMessage, "dev-nanum");

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

            nanumImageDTOs.add(NanumImageDTO.of(nanumImage));

//            KafkaMessage<NanumImageDTO> nanumImageDTOKafkaMessage = KafkaMessage.create().body(nanumImageDTO);
//            producer.sendMessage(nanumImageDTOKafkaMessage, "dev-nanumimage");

            if (isThumbnail) {
                nanum.updateThumbnail(path);
                nanumDTO.setThumbnail(path);
            }
            isThumbnail = false;
        }

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
        Optional<Follower> follow = followerRepository.findByFollowingAndFollower(nanum.getProvider(), follower);

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
        Optional<Bookmark> bookmark = bookmarkRepository.findByNanumAndUser(nanum, follower);
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

        if (nanum.getIsCertification()) {
            userNanum.updateIsCertificated(false);
        } //
        else {
            userNanum.updateIsCertificated(true);
        }

        userNanumRepository.save(userNanum);

        UserNanumDTO userNanumDTO = UserNanumDTO.of(userNanum);
        KafkaMessage<UserNanumDTO> userNanumDTOKafkaMessage = KafkaMessage.update().body(userNanumDTO);
        producer.sendMessage(userNanumDTOKafkaMessage, "dev-usernanum");

        List<UserNanum> userNanums = userNanumRepository.findAllByNanumAndIsCertificatedTrue(nanum);
        if (userNanums.size() == nanum.getQuantity()) {
            nanum.updateStatus(1);

            NanumDTO nanumDTO = NanumDTO.of(nanum);
            KafkaMessage<NanumDTO> nanumDTOKafkaMessage = KafkaMessage.update().body(nanumDTO);
            producer.sendMessage(nanumDTOKafkaMessage, "dev-nanum");
        }
    }

    @Override
    public List<ResNanumDTO> readPopularNaums() {

        List<Nanum> nanums = nanumRepository.findAllByStatusLessThan(3);
        Map<Nanum, Double> popularMap = new HashMap<>();
        for (Nanum nanum : nanums) {
            List<Bookmark> bookmarks = bookmarkRepository.findAllByNanum(nanum);
            popularMap.put(nanum, bookmarks.size() * 0.7 + nanum.getViews() * 0.3);
        }

        List<Nanum> keySet = new ArrayList<>(popularMap.keySet());
        keySet.sort((o1, o2) -> popularMap.get(o2).compareTo(popularMap.get(o1)));

        List<ResNanumDTO> resNanumDTOs = new ArrayList<>();
        keySet.subList(0, 9).forEach(nanum -> {
            resNanumDTOs.add(ResNanumDTO.of(nanum));
        });

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
}
