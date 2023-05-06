package nnz.adminservice.service.impl;

import io.github.eello.nnz.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import nnz.adminservice.dto.AskedShowDTO;
import nnz.adminservice.entity.AskedShow;
import nnz.adminservice.exception.ErrorCode;
import nnz.adminservice.repository.AskedShowRepository;
import nnz.adminservice.repository.UserRepository;
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
    private final UserRepository userRepository;
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
}
