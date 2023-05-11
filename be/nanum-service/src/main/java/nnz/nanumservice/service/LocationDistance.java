package nnz.nanumservice.service;

import org.springframework.stereotype.Component;

@Component
public class LocationDistance {

    /**
     * 두 지점간의 거리 계산
     *
     * @param lat1 지점 1 위도
     * @param lng1 지점 1 경도
     * @param lat2 지점 2 위도
     * @param lng2 지점 2 경도
     * @return
     */
    public Double getDistance(Double lat, Double lnt, Double lat2, Double lnt2) {
        double theta = lnt - lnt2;
        double dist = Math.sin(deg2rad(lat)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515 * 1609.344;

        return dist / 1000;
    }

    //10진수를 radian(라디안)으로 변환
    private static double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }

    //radian(라디안)을 10진수로 변환
    private static double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }
}
