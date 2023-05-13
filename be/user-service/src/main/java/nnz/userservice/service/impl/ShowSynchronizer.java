package nnz.userservice.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.entity.Show;
import nnz.userservice.repository.ShowRepository;
import nnz.userservice.service.DBSynchronizer;
import nnz.userservice.vo.ShowSyncVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class ShowSynchronizer implements DBSynchronizer<ShowSyncVO> {

    private final ShowRepository showRepository;

    @Override
    public void create(ShowSyncVO vo) {
        log.info("Show Create: 공연 id: {}", vo.getId());
        if (vo.getId() == null) {
            log.warn("Show Create fail -> 공연 id is Null");
            return;
        }

        if (showRepository.existsById(vo.getId())) {
            log.info("공연 id: {} is already exists.", vo.getId());
            update(vo);
        }

        Show show = Show.builder()
                .id(vo.getId())
                .title(vo.getTitle())
                .location(vo.getLocation())
                .posterImage(vo.getPosterImage())
                .ageLimit(vo.getAgeLimit())
                .startDate(vo.getStartDate())
                .endDate(vo.getEndDate())
                .isDelete(vo.getIsDelete())
                .updatedAt(vo.getUpdatedAt())
                .build();
        showRepository.save(show);

        log.info("Show Create Success: 공연: {}", show);
    }

    @Override
    public void update(ShowSyncVO vo) {
        log.info("Show Update -> 공연 id: {}", vo.getId());

        Show show = showRepository.findById(vo.getId()).orElse(null);
        if (show == null) {
            log.info("Show Update Fail: 공연 id {} -> Show NotFound", vo.getId());
            return;
        }

        show
                .updateTitle(vo.getTitle())
                .updateLocation(vo.getLocation())
                .updateStartDate(vo.getStartDate())
                .updateEndDate(vo.getEndDate())
                .updateAgeLimit(vo.getAgeLimit())
                .updatePosterImage(vo.getPosterImage())
                .update(vo.getUpdatedAt());

        log.info("Show Update Success: 공연: {}", show);
    }

    @Override
    public void delete(ShowSyncVO vo) {

    }
}
