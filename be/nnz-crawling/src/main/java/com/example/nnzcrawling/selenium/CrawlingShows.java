package com.example.nnzcrawling.selenium;

import com.example.nnzcrawling.dto.CrawlingShowDTO;
import com.example.nnzcrawling.entity.ShowCrawling;
import com.example.nnzcrawling.entity.TagCrawling;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.StringTokenizer;

@Slf4j
@Component
public class CrawlingShows {

    private final String WEB_DRIVER_ID = "webdriver.chrome.driver";
//    private final String WEB_DRIVER_PATH = "/usr/bin/chromedriver";
    private final String WEB_DRIVER_PATH = "C:\\Users\\yyh77\\nnz\\S08P31B207\\be\\nnz-crawling\\chromedriver";

//    @Value("${web-driver.chrome.driver-path}")
//    private String webDriverPath;

    private List<TagCrawling> tags = new ArrayList<>();

    public List<ShowCrawling> getCrawlingData() throws InterruptedException {
        log.info("Show crawling start.");
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

//        //크롬 설정을 담은 객체 생성
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");
        options.addArguments("--headless");
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

//        위에서 설정한 옵션은 담은 드라이버 객체 생성
//        옵션을 설정하지 않았을 때에는 생략 가능하다.
//        WebDriver객체가 곧 하나의 브라우저 창이라 생각한다.
        WebDriver driver = new ChromeDriver(options);

        //이동을 원하는 url
        String url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&qvt=0&query=%EA%B3%B5%EC%97%B0";

        //WebDriver을 해당 url로 이동한다.
        driver.get(url);

        //브라우저 이동시 생기는 로드시간을 기다린다.
        //HTTP응답속도보다 자바의 컴파일 속도가 더 빠르기 때문에 임의적으로 1초를 대기한다.
        Thread.sleep(1000);

        List<CrawlingShowDTO> shows = new ArrayList<>();

        List<WebElement> categories = driver.findElements(By.cssSelector(
                "div.list_type.switch > div > div > div.lego_scroll_middle > div > div > ul > li"
        ));

        // 1번 인덱스는 전체 탭이므로 스킵
        int categoryCnt = 2;
        while (categoryCnt <= categories.size()) {
//        while (categoryCnt <= 2) {

            Thread.sleep(1000);
            // 공연의 카테고리 선택하기.
            WebElement selectCategory =
                    driver.findElement(
                            By.cssSelector(
                                    "div.list_type.switch > div > div > div.lego_scroll_middle > div > div > ul > li:nth-child(" + categoryCnt + ") > a"
                            ));

            String category = selectCategory.getText();
            // 카테고리 하나 클릭
            selectCategory.sendKeys(Keys.ENTER);

            Thread.sleep(1000);

            int regionCnt = 2;

            // 공연 카테고리 선택 후 지역 목록 선택하기
            while (regionCnt <= 16) {

                WebElement regionSelectBox = null;
                if (categoryCnt <= 6) {
                    regionSelectBox = driver.findElement(By.cssSelector("div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > a"));
                } else {
                    regionSelectBox = driver.findElement(By.cssSelector("div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(1) > a"));
                }
                regionSelectBox.sendKeys(Keys.ENTER);

                Thread.sleep(1000);

                // 지역 선택
                WebElement regions = null;
                if (categoryCnt <= 6) {
                    regions = driver.findElement(
                            By.cssSelector(
                                    "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                    //div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > div > div > div > div > div > ul > li:nth-child(2) > a
                            ));
                } else {
                    regions = driver.findElement(
                            By.cssSelector(
                                    "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(1) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                            ));
                }

                String selectRegion = regions.getText();
                Thread.sleep(1000);
                try {
                    regions.sendKeys(Keys.ENTER);
                } catch (Exception e) {
                    if (categoryCnt <= 6) {
                        regions = driver.findElement(
                                By.cssSelector(
                                        "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                ));
                    } else {
                        regions = driver.findElement(
                                By.cssSelector(
                                        "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(1) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                ));
                    }

                    Thread.sleep(1000);
                    try {
                        regions.sendKeys(Keys.ENTER);
                    } catch (Exception e2) {
                        Thread.sleep(1000);
                        if (categoryCnt <= 6) {
                            regions = driver.findElement(
                                    By.cssSelector(
                                            "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                    ));
                        } else {
                            regions = driver.findElement(
                                    By.cssSelector(
                                            "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(1) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                    ));
                        }

                        Thread.sleep(2000);
                        try {
                            regions.sendKeys(Keys.ENTER);
                        } catch (Exception e3) {
                            Thread.sleep(2000);
                            if (categoryCnt <= 6) {
                                regions = driver.findElement(
                                        By.cssSelector(
                                                "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                        ));
                            } else {
                                regions = driver.findElement(
                                        By.cssSelector(
                                                "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(1) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                        ));
                            }
                            try {
                                regions.sendKeys(Keys.ENTER);
                            } catch (Exception e4) {
                                Thread.sleep(2000);
                                if (categoryCnt <= 6) {
                                    regions = driver.findElement(
                                            By.cssSelector(
                                                    "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(2) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                            ));
                                } else {
                                    regions = driver.findElement(
                                            By.cssSelector(
                                                    "div.cm_content_wrap > div > div > div.cm_tap_area.type_performance > div > div > ul > li:nth-child(1) > div > div > div > div > div > ul > li:nth-child(" + regionCnt + ") > a"
                                            ));
                                }
                                regions.sendKeys(Keys.ENTER);
                            }
                        }
                    }
                }
                Thread.sleep(1000);

                // 지역 선택했으면 페이징 처리된 만큼 반복문 진행
                // 페이징 개수 구하기 위한 변수
                int totalPage = 0;

                try {
                    totalPage = Integer.parseInt(
                            driver.findElement(
                                    By.cssSelector(
                                            "div.cm_content_wrap > div > div > div._info > div.cm_paging_area > div > span > span._total"
                                    )).getText());
                } catch (NumberFormatException e) {
                    totalPage = 0;
                }
                int kk = 1;
                for (int k = 1; k < totalPage; k++) {

                    // 다음 버튼 누르기
                    for (int i = 1; i < kk; i++) {
                        driver.navigate().back();
                        Thread.sleep(1000);
                    }

                    List<WebElement> showList = driver.findElements(
                            By.cssSelector(
                                    "div.cm_content_wrap > div > div > div._info > div.list_image_info.type_pure._panel_wrapper > ul:nth-child(" + k + ") > li > a"
                            ));

                    // 공연 정보들의 태그를 리스트에 담고 해당 리스트에서 <a> 태그 정보를 받아와 url 이동.
                    // 해당 메소드에서는 태그 정보만 담는다.
                    showList.forEach(element -> {
                        shows.add(new CrawlingShowDTO(element, element.getAttribute("href"), category, selectRegion));
                    });

                    WebElement nextBtn = driver.findElement(By.cssSelector("div.cm_content_wrap > div > div > div._info > div.cm_paging_area > div > a.pg_next.on"));
                    nextBtn.sendKeys(Keys.ENTER);
                    Thread.sleep(1000);
                }
                regionCnt++;

                Thread.sleep(1000);
                kk++;
            }
            categoryCnt++;
        }

        List<ShowCrawling> responses = getShowInfo(driver, shows);

        try {
            //드라이버가 null이 아니라면
            if (driver != null) {
                //드라이버 연결 종료
                driver.close(); //드라이버 연결 해제

                //프로세스 종료
                driver.quit();
            }
        } catch (
                Exception e) {
            throw new RuntimeException(e.getMessage());
        }

        log.info("Show crawling end.");
        return responses;
    }

    private List<ShowCrawling> getShowInfo(WebDriver driver, List<CrawlingShowDTO> shows) {

        List<ShowCrawling> showCrawlingRespons = new ArrayList<>();

        shows.forEach(v -> {
            ShowCrawling showCrawling = new ShowCrawling();

            driver.get(v.getHref());

            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            // 공연 제목
            String title = null;
            try {
                title = driver.findElement(By.cssSelector("div.cm_top_wrap._sticky._custom_select._header > div.title_area.type_keep._title_area > h2 > span.area_text_title > strong")).getText();
            } catch (Exception e) {
                return;
            }
            showCrawling.setTitle(title);

            // 공연 장소 - ~박물관, ~공연장
            String location = null;
            try {
                location = driver.findElement(
                        By.cssSelector(
                                "div > div.detail_info._default_info > dl > div:nth-child(4) > dd > a"
                        )).getText();
            } catch (Exception e) {
                try {
                    location = driver.findElement(
                            By.cssSelector(
                                    "div > div.detail_info._default_info > dl > div:nth-child(3) > dd > a"
                            )).getText();
                } catch (Exception e2) {
                    location = driver.findElement(
                            By.cssSelector(
                                    "div > div.detail_info > dl > div:nth-child(3) > dd"
                            )).getText();
                }
            }
            showCrawling.setLocation(location);

            // 시작 일자
            String startDate = null;
            // 종료 일자
            String endDate = null;

            try {
                startDate = driver.findElement(
                        By.cssSelector(
                                "div.detail_info._default_info > dl > div:nth-child(2) > dd > span:nth-child(1)"
                        )).getText();
                endDate = driver.findElement(
                        By.cssSelector(
                                "div.detail_info._default_info > dl > div:nth-child(2) > dd > span:nth-child(2)"
                        )).getText();
            } catch (Exception e) {
                try {
                    startDate = driver.findElement(
                            By.cssSelector(
                                    "div > div:nth-child(1) > div > div.detail_info > dl > div:nth-child(2) > dd > span"
                            )).getText();
                    endDate = "";
                } catch (Exception e2) {
                    startDate = driver.findElement(By.cssSelector(
                            "div > div > div.detail_info._default_info > dl > div:nth-child(2) > dd"
                    )).getText();
                    endDate = "";
                }
            }

            if (endDate.equals("")) {
                StringTokenizer st = new StringTokenizer(startDate, "~ ");
                startDate = st.nextToken();
                try {
                    endDate = st.nextToken();
                } catch (NoSuchElementException nullException) {
                    // 그냥 넘어가면 된다. endDate 없음
                }
            }
            showCrawling.setStartDate(startDate.trim());
            showCrawling.setEndDate(endDate.trim());

            // 연령 제한
            String ageLimit = null;
            try {
                ageLimit = driver.findElement(By.cssSelector("div.cm_top_wrap._sticky._custom_select._header > div.title_area.type_keep._title_area > div > span:nth-child(3)")).getText();
            } catch (Exception e) {
                ageLimit = "";
            }
            showCrawling.setAgeLimit(ageLimit);

            // 지역
            showCrawling.setRegion(v.getRegion());
            tags.add(new TagCrawling(title, v.getRegion()));


            // 포스터 이미지 url
            String poster = null;
            try {
                poster = driver.findElement(
                        By.cssSelector(
                                "div.cm_content_wrap._content > div.cm_content_area._scroll_mover > div > div.detail_info._default_info > a > img"
                        )).getAttribute("src");
            } catch (Exception e) {
                try {
                    poster = driver.findElement(
                            By.cssSelector(
                                    "div.cm_content_wrap._content > div.cm_content_area._scroll_mover > div > div.detail_info._default_info > span > img"
                            )).getAttribute("src");
                } catch (Exception e2) {
                    poster = driver.findElement(
                            By.cssSelector(
                                    "div.cm_content_wrap._kgs_perform_festival > div > div:nth-child(1) > div > div.detail_info > a > img"
                            )).getAttribute("src");
                }
            }
            showCrawling.setPosterImage(poster);

            // 카테고리
            showCrawling.setCategory(v.getCategory());
            tags.add(new TagCrawling(title, v.getCategory()));

            showCrawlingRespons.add(showCrawling);

            // 출연진 정보 크롤링
            List<WebElement> tabs = driver.findElements(By.cssSelector(
                    "div.cm_top_wrap._sticky._custom_select._header > div.sub_tap_area._scrolling_wrapper_common_tab._scroll_mover > div > div > ul > li"
            ));

            for (WebElement tab : tabs) {
                if (tab.getText().equals("출연진")) {
                    try {
                        try {
                            Thread.sleep(1000);
                            // 출연진 태그 클릭
                            tab.sendKeys(Keys.ENTER);
                        } catch (Exception e) {
                            try {
                                Thread.sleep(1000);
                                tab.click();
                            } catch (Exception e2) {
                                Thread.sleep(1000);
                                tab.sendKeys(Keys.ENTER);
                            }
                        }
                        Thread.sleep(1000);

                        List<WebElement> actors = driver.findElements(By.cssSelector(
                                "div.cm_content_wrap._content._people_content > div > div:nth-child(2) > div.list_image_info > ul > li > div > div > strong > a"
                        ));

                        for (WebElement actor : actors) {
                            tags.add(new TagCrawling(title, actor.getText()));
                        }

                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }

                    break;
                }
            }
        });

        return showCrawlingRespons;
    }

    public List<TagCrawling> getTags() {
        return tags;
    }
}
