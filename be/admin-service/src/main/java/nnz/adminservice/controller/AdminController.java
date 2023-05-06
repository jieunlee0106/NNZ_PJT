package nnz.adminservice.controller;

import lombok.RequiredArgsConstructor;
import nnz.adminservice.service.AdminService;
import nnz.adminservice.vo.AskedShowStatusVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin-service/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/ask/show")
    public ResponseEntity<?> findAskedShowList(){
        return ResponseEntity.ok(adminService.findAskedShowList());
    }

    @PatchMapping("/ask/show")
    public ResponseEntity<?> handleAskedShow(@RequestBody AskedShowStatusVO askedShowStatusVO){
        adminService.handleAskedShow(askedShowStatusVO);
        return ResponseEntity.ok().build();
    }
}
