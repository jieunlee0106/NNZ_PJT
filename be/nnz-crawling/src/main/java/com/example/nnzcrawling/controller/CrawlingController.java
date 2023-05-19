package com.example.nnzcrawling.controller;

import com.example.nnzcrawling.service.impl.ShowCrawlingServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/crawling")
public class CrawlingController {

    private final ShowCrawlingServiceImpl showCrawlingService;

    @PostMapping
    public ResponseEntity<Void> createShows() {
        showCrawlingService.createShow();
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
