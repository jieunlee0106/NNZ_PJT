package com.example.nnzcrawling.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
@ToString
public class ShowCrawling {

    private Long id;

    private String title;

    private String location;

    private String startDate;

    private String endDate;

    private String ageLimit;

    private String region;

    private String posterImage;

    // e스포츠 -> 롤, 배그, 오버워치 등등..
    private String category;
}
