package nnz.adminservice.service;

import nnz.adminservice.dto.AskedShowDTO;

import java.util.List;

public interface AdminService {
    List<AskedShowDTO> findAskedShowList();
}
