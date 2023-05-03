package nnz.adminservice.controller;

import lombok.RequiredArgsConstructor;
import nnz.adminservice.service.AdminService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/ask/show")
    public ResponseEntity<?> findAskedShowList(){
        return ResponseEntity.ok(adminService.findAskedShowList());
    }
}
