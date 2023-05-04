package com.example.nnzcrawling.entity;

import com.example.nnzcrawling.util.converter.ShowConverter;
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

    @Convert(converter = ShowConverter.class)
    private String location;

    @Convert(converter = ShowConverter.class)
    private String startDate;

    @Convert(converter = ShowConverter.class)
    private String endDate;

    @Convert(converter = ShowConverter.class)
    private String ageLimit;

    @Convert(converter = ShowConverter.class)
    private String region;

    @Convert(converter = ShowConverter.class)
    private String posterImage;

    // e스포츠 -> 롤, 배그, 오버워치 등등..
    private String category;
}
