package com.example.nnzcrawling.repository.impl;

import com.example.nnzcrawling.entity.ShowCrawling;
import com.example.nnzcrawling.repository.ShowCrawlingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ParameterizedPreparedStatementSetter;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class ShowCrawlingRepositoryImpl implements ShowCrawlingRepository {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public void createShows(List<ShowCrawling> showCrawlings) {
        jdbcTemplate.batchUpdate(
                "insert ignore into shows " +
                        "(title, location, start_date, end_date, " +
                        "age_limit, region, poster_image, category_code, " +
                        "is_delete, created_at, updated_at) " +
                        "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);",
                showCrawlings,
                showCrawlings.size(),
                new ParameterizedPreparedStatementSetter<ShowCrawling>() {
                    @Override
                    public void setValues(PreparedStatement ps, ShowCrawling showCrawling) throws SQLException {
                        ps.setString(1, showCrawling.getTitle());
                        ps.setString(2, showCrawling.getLocation());
                        ps.setString(3, showCrawling.getStartDate());
                        ps.setString(4, showCrawling.getEndDate());
                        ps.setString(5, showCrawling.getAgeLimit());
                        ps.setString(6, showCrawling.getRegion());
                        ps.setString(7, showCrawling.getPosterImage());
                        ps.setString(8, showCrawling.getCategory());
                        ps.setBoolean(9, false);
                        ps.setString(10, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")));
                        ps.setString(11, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")));
                    }
                }
        );
    }
}
