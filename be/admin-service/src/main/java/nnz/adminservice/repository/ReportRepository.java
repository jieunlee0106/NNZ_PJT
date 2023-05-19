package nnz.adminservice.repository;

import nnz.adminservice.entity.Report;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReportRepository extends JpaRepository<Report, Long> {
    List<Report> findAllByStatus(Report.ReportStatus code);
}
