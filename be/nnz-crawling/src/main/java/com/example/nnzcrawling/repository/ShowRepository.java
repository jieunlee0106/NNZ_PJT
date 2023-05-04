package com.example.nnzcrawling.repository;

import com.example.nnzcrawling.entity.Show;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ShowRepository extends JpaRepository<Show, Long> {

    List<Optional<Show>> findByTitleContaining(String title);
}
