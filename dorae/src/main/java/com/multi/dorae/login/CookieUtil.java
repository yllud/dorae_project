package com.multi.dorae.login;

import java.net.URLEncoder;
import java.net.URLDecoder;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

public class CookieUtil {
    public static String getCookieValue(HttpServletRequest request, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    try {
                        return URLDecoder.decode(cookie.getValue(), "UTF-8");
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return null;
    }

    public static void setCookieValue(HttpServletResponse response, String cookieName, String value) throws UnsupportedEncodingException {
        Cookie cookie = new Cookie(cookieName, URLEncoder.encode(value, "UTF-8"));
        cookie.setMaxAge(365 * 24 * 60 * 60); // 1년 동안 유지되도록 설정
        cookie.setPath("/"); // 전체 애플리케이션에서 쿠키 사용 가능
        response.addCookie(cookie);
    }
}