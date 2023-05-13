package nnz.userservice.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.Nanum.NanumStatus;
import nnz.userservice.entity.NanumTag;
import nnz.userservice.entity.Show;
import nnz.userservice.entity.User;
import nnz.userservice.repository.NanumRepository;
import nnz.userservice.repository.NanumTagRepository;
import nnz.userservice.repository.ShowRepository;
import nnz.userservice.repository.UserRepository;
import nnz.userservice.service.DBSynchronizer;
import nnz.userservice.vo.sync.NanumSyncVO;
import nnz.userservice.vo.sync.NanumSyncVO.NanumTagSyncVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class NanumSynchronizer implements DBSynchronizer<NanumSyncVO> {

    private final NanumRepository nanumRepository;
    private final NanumTagRepository tagRepository;
    private final UserRepository userRepository;
    private final ShowRepository showRepository;

    @Override
    public void create(NanumSyncVO vo) {
        log.info("Nanum Create: 나눔 id: {}", vo.getId());
        if (vo.getId() == null) {
            log.warn("Nanum Create Fail -> 나눔 id is Null");
            return;
        }

        if (vo.getProviderId() == null) {
            log.warn("Nanum Create Fail -> 유저 id is null");
            return;
        }

        // provider 조회
        User provider = userRepository.findById(vo.getProviderId()).orElse(null);
        if (provider == null) {
            log.warn("Nanum Create Fail -> 유저 id: {} is Null", vo.getProviderId());
            return;
        }

        // show 조회
        Show show = showRepository.findById(vo.getShowId()).orElse(null);
        if (show == null) {
            log.warn("Nanum Create Fail -> 공연 id: {} is Null", vo.getShowId());
            return;
        }

        // 이미 존재하는 나눔이면 업데이트
        if (nanumRepository.existsById(vo.getId())) {
            update(vo);
            return;
        }

        // 나눔 생성 및 저장
        Nanum nanum = Nanum.builder()
                .id(vo.getId())
                .title(vo.getTitle())
                .thumbnail(vo.getThumbnail())
                .date(vo.getDate())
                .location(vo.getLocation())
                .isCertification(vo.getIsCertification())
                .status(NanumStatus.valueOf(vo.getStatus()))
                .provider(provider)
                .show(show)
                .updatedAt(vo.getUpdatedAt())
                .build();
        nanumRepository.save(nanum);

        // 나눔 태그 생성 및 저장
        List<NanumTag> tags = new ArrayList<>();
        for (NanumTagSyncVO nanumTag : vo.getNanumTags()) {
            NanumTag tag = NanumTag.builder()
                    .id(nanumTag.getId())
                    .tag(nanumTag.getTag().getTag())
                    .nanum(nanum)
                    .build();
            tags.add(tag);
        }
        tagRepository.saveAll(tags);

        log.info("Nanum Create Success: 나눔: {}", nanum);
    }

    @Override
    public void update(NanumSyncVO vo) {
        log.info("Nanum Update -> 나눔 id: {}", vo.getId());

        Nanum nanum = nanumRepository.findById(vo.getId()).orElse(null);
        if (nanum == null) {
            log.warn("Nanum Update Fail: 나눔 id {} -> Nanum NotFound", vo.getId());
            return;
        }

        // 나눔 업데이트
        nanum
                .updateTitle(vo.getTitle())
                .updateThumbnail(vo.getThumbnail())
                .updateDate(vo.getDate())
                .updateLocation(vo.getLocation())
                .updateStatus(NanumStatus.valueOf(vo.getStatus()))
                .updateIsCertification(vo.getIsCertification())
                .update(vo.getUpdatedAt());

        // 기존 태그 삭제 후 재생성
        tagRepository.deleteByNanum(nanum);

        // 나눔 태그 재생성
        List<NanumTag> tags = new ArrayList<>();
        for (NanumTagSyncVO nanumTag : vo.getNanumTags()) {
            NanumTag tag = NanumTag.builder()
                    .id(nanumTag.getId())
                    .tag(nanumTag.getTag().getTag())
                    .nanum(nanum)
                    .build();
            tags.add(tag);
        }
        tagRepository.saveAll(tags);

        log.info("Nanum Update Success: 나눔: {}", nanum);
    }

    @Override
    public void delete(NanumSyncVO vo) {

    }
}
