package nnz.userservice.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtils {

    public static Cookie getCookieByName(HttpServletRequest request, String name) {
        for (Cookie cookie : request.getCookies()) {
            if (name.equals(cookie.getName())) {
                return cookie;
            }
        }

        return null;
    }
}
