package com.example.nnzcrawling.service.impl;

import com.example.nnzcrawling.service.ShowCrawlingService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ShowCrawlingServiceImplTest {

    @Autowired
    ShowCrawlingService showCrawlingService;

    @Test
    public void test() {
        showCrawlingService.createShow();
    }

}