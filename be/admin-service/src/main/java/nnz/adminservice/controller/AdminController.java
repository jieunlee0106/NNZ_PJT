package nnz.adminservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import nnz.adminservice.service.AdminService;
import nnz.adminservice.vo.AskedShowStatusVO;
import nnz.adminservice.vo.ReportStatusVO;
import nnz.adminservice.vo.ShowVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin-service/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/ask/shows")
    public ResponseEntity<?> findAskedShowList(){
        return ResponseEntity.ok(adminService.findAskedShowList());
    }

    @PatchMapping("/ask/shows")
    public ResponseEntity<?> handleAskedShow(@RequestBody AskedShowStatusVO askedShowStatusVO) throws JsonProcessingException {
        adminService.handleAskedShow(askedShowStatusVO);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ask/shows")
    public ResponseEntity<?> createShow(@RequestPart(name = "ShowVO") ShowVO showVO,
                                        @RequestPart(name = "poster") MultipartFile file){
        adminService.createShow(showVO, file);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/ask/reports")
    public ResponseEntity<?> findReportList(){
        return ResponseEntity.ok(adminService.findReportList());
    }

    @PatchMapping("/ask/reports")
    public ResponseEntity<?> handleReport(@RequestBody ReportStatusVO reportStatusVO) throws JsonProcessingException {
        adminService.handleReport(reportStatusVO);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/banners")
    public ResponseEntity<?> registBanners(@RequestPart(value = "banners", required = false) List<MultipartFile> files,
                                           @RequestPart(value = "showIds") List<Long> showIDsVO) throws JsonProcessingException {
        adminService.registBanners(files, showIDsVO);
        return ResponseEntity.ok().build();
    }
}
