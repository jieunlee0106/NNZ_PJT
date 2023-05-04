package com.example.nnzcrawling.selenium;

import com.example.nnzcrawling.entity.ShowCrawling;
import com.example.nnzcrawling.entity.TagCrawling;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.*;

@Component
public class CrawlingSports {

    private final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    private final String WEB_DRIVER_PATH = "C:\\Users\\yyh77\\nnz\\S08P31B207\\be\\nnz-crawling\\chromedriver.exe";
    private List<TagCrawling> tags = new ArrayList<>();

    public List<ShowCrawling> getCrawlingData() throws InterruptedException {

        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");
        WebDriver driver = new ChromeDriver(options);

        List<ShowCrawling> responses = new ArrayList<>();

        // 야구
        responses.addAll(getBaseBall(driver));
        // 축구
        responses.addAll(getSoccer(driver));
        // 농구
        responses.addAll(getBasketball(driver));

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

        return responses;
    }

    private List<ShowCrawling> getBaseBall(WebDriver driver) throws InterruptedException {

        String url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&mra=bjA5&qvt=0&query=%EC%95%BC%EA%B5%AC%20%EA%B2%BD%EA%B8%B0%EC%9D%BC%EC%A0%95";
        driver.get(url);

        List<ShowCrawling> shows = getShowInfo(driver, "야구");

        return shows;
    }

    private List<ShowCrawling> getSoccer(WebDriver driver) throws InterruptedException {

        String url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&mra=bjA5&qvt=0&query=%EC%B6%95%EA%B5%AC%20%EA%B2%BD%EA%B8%B0%EC%9D%BC%EC%A0%95";
        driver.get(url);

        List<ShowCrawling> shows = getShowInfo(driver, "축구");

        return shows;
    }

    private List<ShowCrawling> getBasketball(WebDriver driver) throws InterruptedException {

        String url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&mra=bjA5&qvt=0&query=%EB%86%8D%EA%B5%AC%20%EA%B2%BD%EA%B8%B0%EC%9D%BC%EC%A0%95";
        driver.get(url);

        List<ShowCrawling> shows = getShowInfo(driver, "농구");

        return shows;
    }

    private List<ShowCrawling> getShowInfo(WebDriver driver, String category) throws InterruptedException {

        Thread.sleep(1000);

        List<ShowCrawling> shows = new ArrayList<>();
        Map<String, String> recordUrls = new HashMap<>();

        int year = LocalDate.now().getYear();

        // 오늘 날짜 기준으로 10일치 경기 일정 받아오기
        timeLoop:
        for (int i = 0; i < 10; i++) {
            // 받아올 정보 : title, location, startDate, category, poster

            Thread.sleep(1000);

            String day = null;
            try {
                day = driver.findElement(By.cssSelector(
                        "div.api_cs_wrap > div.db_area._schedule_info > div.nv_date.today > strong"
                )).getText();
            } catch (Exception e) {
                day = driver.findElement(By.cssSelector(
                        "div.api_cs_wrap > div.db_area._schedule_info > div.nv_date > strong"
                )).getText();
            }

            // 해당 날짜
            String date = year + "." + day;
            StringTokenizer st = new StringTokenizer(date, "(");
            // 요일 정보 삭제
            date = st.nextToken();
            date = date.replace(". ", "T");

            // 시간
            List<WebElement> times = driver.findElements(By.cssSelector(
                    "div.db_area._schedule_info > div.db_list.db_list_flex > table > tbody > tr > td.time > div > span"
            ));

            // 왼쪽 팀
            List<WebElement> leftTeams = driver.findElements(By.cssSelector(
                    "div.db_area._schedule_info > div.db_list.db_list_flex > table > tbody > tr > td.l_team > span > a"
            ));

            // 오른쪽 팀
            List<WebElement> rightTeams = driver.findElements(By.cssSelector(
                    "div.db_area._schedule_info > div.db_list.db_list_flex > table > tbody > tr > td.r_team > span > a"
            ));

            // 장소
            List<WebElement> locations = driver.findElements(By.cssSelector(
                    "div.api_cs_wrap > div.db_area._schedule_info > div.db_list.db_list_flex > table > tbody > tr > td.place"
            ));

            for (int j = 0; j < times.size(); j++) {
                // times, leftTeams, rightTeams, locations, records
                ShowCrawling showCrawling = new ShowCrawling();

                String leftTeam = leftTeams.get(j).getAttribute("title");
                String rightTeam = rightTeams.get(j).getAttribute("title");
                String lTeamImg = null;
                String rTeamImg = null;
                try {
                    Thread.sleep(1000);
                    lTeamImg = driver.findElement(By.cssSelector(
                            "table > tbody > tr:nth-child(1) > td.l_team > a > img"
                    )).getAttribute("src");
                    rTeamImg = driver.findElement(By.cssSelector(
                            "table > tbody > tr:nth-child(1) > td.r_team > a > img"
                    )).getAttribute("src");
                } catch (Exception e) {
                    Thread.sleep(1000);
                    lTeamImg = driver.findElement(By.cssSelector(
                            "table > tbody > tr:nth-child(1) > td.l_team > a > img"
                    )).getAttribute("src");
                    rTeamImg = driver.findElement(By.cssSelector(
                            "table > tbody > tr:nth-child(1) > td.r_team > a > img"
                    )).getAttribute("src");
                }
                String title = leftTeam + " vs " + rightTeam;

                showCrawling.setStartDate(date + times.get(j).getText());
                showCrawling.setCategory(category);
                showCrawling.setTitle(title);
                showCrawling.setPosterImage(lTeamImg + " vs " + rTeamImg);
                tags.add(new TagCrawling(title, leftTeam));
                tags.add(new TagCrawling(title, rightTeam));
                showCrawling.setLocation(locations.get(j).getText());
                tags.add(new TagCrawling(title, locations.get(j).getText()));

                // 태그 저장을 위해 구글링으로 선수명단 따와야 하니 url 다 저장해놓기
                recordUrls.put(leftTeam, "https://www.google.com/search?q=" + leftTeam + "+" + "선수");
                recordUrls.put(rightTeam, "https://www.google.com/search?q=" + rightTeam + "+" + "선수");
                shows.add(showCrawling);
            }

            // 다음 일정 버튼 누르기
            try {
                driver.findElement(By.cssSelector(
                        "div.api_cs_wrap > div.db_area._schedule_info > div.nv_date.today > a.bt_nx"
                )).sendKeys(Keys.ENTER);
            } catch (Exception e) {
                try {
                    driver.findElement(By.cssSelector(
                            "div.api_cs_wrap > div.db_area._schedule_info > div.nv_date > a.bt_nx"
                    )).sendKeys(Keys.ENTER);
                } catch (Exception e2) {
                    break timeLoop;
                }
            }
            Thread.sleep(1000);
        }

        // 선수명단 태그에 저장하기 위해 태그 리스트에 추가하는 메소드
        getPlayerInfo(driver, recordUrls);

        return shows;
    }

    private void getPlayerInfo(WebDriver driver, Map<String, String> recordUrls) throws InterruptedException {

        List<String> teams = new ArrayList<>(recordUrls.keySet());

        for (String team : teams) {

            // 선수명단을 불러오기 위한 url로 이동
            driver.get(recordUrls.get(team));
            Thread.sleep(1000);

            List<WebElement> players = driver.findElements(By.cssSelector(
                    "div.mR2gOd > div > a > div > div > div.WGwSK.ghJsNe > div > div:nth-child(1) > div"
            ));

            for (WebElement player : players) {
                tags.add(new TagCrawling(team, player.getText()));
            }

            Thread.sleep(1000);
        }
    }

    public List<TagCrawling> getTags() {
        return tags;
    }
}
