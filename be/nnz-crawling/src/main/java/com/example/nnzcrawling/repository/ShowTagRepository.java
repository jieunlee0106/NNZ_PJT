package com.example.nnzcrawling.repository;

import com.example.nnzcrawling.entity.Show;
import com.example.nnzcrawling.entity.ShowTag;
import com.example.nnzcrawling.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ShowTagRepository extends JpaRepository<ShowTag, Long> {

    Optional<ShowTag> findByShowAndTag(Show show, Tag tag);
}
