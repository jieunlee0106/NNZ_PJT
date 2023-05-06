package nnz.adminservice.controller;

import lombok.RequiredArgsConstructor;
import nnz.adminservice.service.AdminService;
import nnz.adminservice.vo.AskedShowStatusVO;
import nnz.adminservice.vo.ReportStatusVO;
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

    @GetMapping("/ask/reports")
    public ResponseEntity<?> findReportList(){
        return ResponseEntity.ok(adminService.findReportList());
    }

    @PatchMapping("/ask/reports")
    public ResponseEntity<?> handleReport(@RequestBody ReportStatusVO reportStatusVO){
        adminService.handleReport(reportStatusVO);
        return ResponseEntity.ok().build();
    }

}
