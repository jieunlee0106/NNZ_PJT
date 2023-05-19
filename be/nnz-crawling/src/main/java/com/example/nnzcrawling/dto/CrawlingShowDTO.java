package com.example.nnzcrawling.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.openqa.selenium.WebElement;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CrawlingShowDTO {

    private WebElement element;

    private String href;

    private String category;

    private String region;
}
