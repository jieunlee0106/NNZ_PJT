package com.example.nnzcrawling.selenium;

import com.example.nnzcrawling.entity.ShowEntity;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import java.util.ArrayList;
import java.util.List;

public class CrawlingESports {

    private static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    private static final String WEB_DRIVER_PATH = "C:\\Users\\yyh77\\nnz\\nnz-crawling\\chromedriver.exe";

    public void getCrawlingData() throws InterruptedException {

        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        //크롬 설정을 담은 객체 생성
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        //브라우저가 눈에 보이지 않고 내부적으로 돈다.
        //설정하지 않을 시 실제 크롬 창이 생성되고, 어떤 순서로 진행되는지 확인할 수 있다.
//        options.addArguments("headless");

        WebDriver driver = new ChromeDriver(options);

        // 리턴할 리스트
        List<ShowEntity> eSports = new ArrayList<>();

        getData(driver, eSports);

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
    }

    private void getData(WebDriver driver, List<ShowEntity> eSports) throws InterruptedException {

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
            category.sendKeys(Keys.ENTER);
            Thread.sleep(1000);
            String title = driver.findElement(
                    By.cssSelector("#categorylist > li:nth-child(" + categoryCnt + ") > a"
                    )).getText();

            // 일정이 적혀 있는 테이블의 tr 태그들을 모두 불러온다
            List<WebElement> schedules = driver.findElements(
                    By.cssSelector(
                            "#esportsBody > div.commu-wrap > section > article > section.commu-center > div.commu-body.pcMain > div > div.contentContainer > div > div.calendarWrap > div > div.body > table > tbody > tr"
                    ));

            for (WebElement tr : schedules) {

                // 일정이 써있는 테이블 위에 있는 월 정보. (일자는 월 정보에 + 해준다.)
                String startDate = driver.findElement(
                        By.cssSelector(
                                "#esportsBody > div.commu-wrap > section > article > section.commu-center > div.commu-body.pcMain > div > div.commonHead > div > div.infoWrap > div > div.date"
                        )).getText();

                // tr에 포함된 td에서 일정 정보를 하나씩 뺴온다.
                List<WebElement> tds = tr.findElements(By.cssSelector("td"));
                for (WebElement td : tds) {

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

                        ShowEntity showEntity = new ShowEntity();

                        showEntity.setCategory(title);

                        // 타이틀 설정
                        showEntity.setTitle(titles.get(i).getText());

                        // 날짜 설정. 시작날짜 = 경기 당일 날짜. 종료날짜는 없음
                        String date = startDate + " " + times.get(i).getText();
                        showEntity.setStartDate(date);

                        eSports.add(showEntity);
                    }
                }
            }
            categoryCnt++;
        }

        for (ShowEntity show : eSports) {
            System.out.println(show);
        }
    }
}
