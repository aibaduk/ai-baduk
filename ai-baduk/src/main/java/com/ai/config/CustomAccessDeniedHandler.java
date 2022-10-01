package com.ai.config;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.util.UrlPathHelper;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    @SuppressWarnings("unused")
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException e) throws IOException, ServletException {
        //스프링 시큐리티 로그인때 만든 객체
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        //현재 접속 URL을 확인
        UrlPathHelper urlPathHelper = new UrlPathHelper();
        String originalURL = urlPathHelper.getOriginatingRequestUri(request);

        //로직을 짜서 상황에 따라 보내줄 주소를 설정해주면 됨
        String errorMessage = "해당 페이지의 권한이 없습니다.";
        response.sendRedirect("/auth/fail?error=true&exception="+URLEncoder.encode(errorMessage, "UTF-8"));
    }
}
