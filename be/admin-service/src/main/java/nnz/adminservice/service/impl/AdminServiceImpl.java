package nnz.adminservice.service.impl;

import lombok.RequiredArgsConstructor;
import nnz.adminservice.dto.AskedShowDTO;
import nnz.adminservice.entity.AskedShow;
import nnz.adminservice.repository.AskedShowRepository;
import nnz.adminservice.service.AdminService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
    private final AskedShowRepository askedShowRepository;
    @Override
    public List<AskedShowDTO> findAskedShowList() {

        List<AskedShow> allByStatus = askedShowRepository.findAllByStatus(AskedShow.AskedShowStatus.WAIT.getCode());

        return allByStatus.stream().map(askedShow -> AskedShowDTO.builder()
                .requester(null) // TODO User 닉네임 찾기
                .title(askedShow.getTitle())
                .path(askedShow.getPath())
                .build()).collect(Collectors.toList());
    }
}
