package com.example.nnzcrawling.selenium;

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
import java.util.StringTokenizer;

@Slf4j
@Component
public class CrawlingESports {

    private final String WEB_DRIVER_ID = "webdriver.chrome.driver";
//    private final String WEB_DRIVER_PATH = "/usr/bin/chromedriver";
    private final String WEB_DRIVER_PATH = "C:\\Users\\yyh77\\nnz\\S08P31B207\\be\\nnz-crawling\\chromedriver.exe";

//    @Value("${web-driver.chrome.driver-path}")
//    private String webDriverPath;


    private List<TagCrawling> tags = new ArrayList<>();

    public List<ShowCrawling> getCrawlingData() throws InterruptedException {
        log.info("ESports crawling start.");
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        // 크롬 설정을 담은 객체 생성
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");
        options.addArguments("--headless");
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

        WebDriver driver = new ChromeDriver(options);

        // 리턴할 리스트
        List<ShowCrawling> eSports = new ArrayList<>();
        eSports = getData(driver, eSports);

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

        log.info("ESports crawling end.");
        return eSports;
    }

    private List<ShowCrawling> getData(WebDriver driver, List<ShowCrawling> eSports) throws InterruptedException {

        //이동을 원하는 url -> 롤 월간 일정
        String url = "https://esports.inven.co.kr/schedule/?mode=month";
        driver.get(url);

        Thread.sleep(1000);

        // 카테고리별로 들어가기
        int categoryCnt = 2;

        while (categoryCnt <= 4) {

            WebElement category = driver.findElement(
                    By.cssSelector("#categorylist > li:nth-child(" + categoryCnt + ") > a"
                    ));
            String categoryName = category.getText();
            category.sendKeys(Keys.ENTER);
            Thread.sleep(1000);
            String title = driver.findElement(
                    By.cssSelector("#categorylist > li:nth-child(" + categoryCnt + ") > a"
                    )).getText();

            Thread.sleep(1000);

//            tags.add(new TagCrawling(categoryName, categoryName));

            // 일정이 적혀 있는 테이블의 tr 태그들을 모두 불러온다
            List<WebElement> schedules = driver.findElements(
                    By.cssSelector(
                            "#esportsBody > div.commu-wrap > section > article > section.commu-center > div.commu-body.pcMain > div > div.contentContainer > div > div.calendarWrap > div > div.body > table > tbody > tr"
                    ));

            for (WebElement tr : schedules) {

                // tr에 포함된 td에서 일정 정보를 하나씩 뺴온다.
                List<WebElement> tds = tr.findElements(By.cssSelector("td"));
                for (WebElement td : tds) {
                    // 일정이 써있는 테이블 위에 있는 월 정보. (일자는 월 정보에 + 해준다.)
                    String startDate = driver.findElement(
                            By.cssSelector(
                                    "#esportsBody > div.commu-wrap > section > article > section.commu-center > div.commu-body.pcMain > div > div.commonHead > div > div.infoWrap > div > div.date"
                            )).getText();

                    if (td.getText().equals(" ")) {
                        continue;
                    }

                    // 일정정보 추출
                    String day = td.findElement(
                            By.cssSelector(
                                    "dl > dt > a"
                            )).getText();

                    startDate += "." + day;

                    // 일정에 붙을 시간 구하기
                    List<WebElement> times = td.findElements(By.cssSelector("span.time"));

                    // title 구하기
                    List<WebElement> titles = td.findElements(By.cssSelector("span.team"));

                    for (int i = 0; i < titles.size(); i++) {

                        ShowCrawling showCrawling = new ShowCrawling();

                        showCrawling.setCategory(title);

                        // 타이틀 설정
                        showCrawling.setTitle(titles.get(i).getText());

                        // 태그 추가 : "vs"를 제외하고 팀 이름 두개 추가하기
                        StringTokenizer st = new StringTokenizer(titles.get(i).getText(), "vs");
                        tags.add(new TagCrawling(titles.get(i).getText(), categoryName));
                        while (st.hasMoreTokens()) {
                            tags.add(new TagCrawling(titles.get(i).getText(), st.nextToken()));
//                            tags.add(new TagCrawling(st.nextToken(), title));
                        }

                        // 날짜 설정. 시작날짜 = 경기 당일 날짜. 종료날짜는 없음
                        String date = startDate + "T" + times.get(i).getText();
                        showCrawling.setStartDate(date);

                        eSports.add(showCrawling);
                    }
                }
            }
            categoryCnt++;
        }
        return eSports;
    }

    public List<TagCrawling> getTags() {
        return tags;
    }
}
