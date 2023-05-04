package com.example.nnzcrawling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class NnzCrawlingApplication {

    public static void main(String[] args) {
        SpringApplication.run(NnzCrawlingApplication.class, args);
    }
}
