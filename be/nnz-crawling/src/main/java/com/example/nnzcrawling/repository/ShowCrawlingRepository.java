package com.example.nnzcrawling.repository;

import com.example.nnzcrawling.entity.ShowCrawling;

import java.util.List;

public interface ShowCrawlingRepository {

    void createShows(List<ShowCrawling> showCrawlings);
}
