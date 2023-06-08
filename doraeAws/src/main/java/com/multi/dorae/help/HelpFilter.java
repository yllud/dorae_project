package com.multi.dorae.help;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebFilter("/help/contact/*") // dorae/help/contact 아래 모든 경로
@WebFilter({"/help/contactOne", "/help/contactList", "/help/contactCreate", "/help/applyBusinessList"})
public class HelpFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpSession session = ((HttpServletRequest) request).getSession();
		
		if (session.getAttribute("email") == null) { // 카카오로 로그인 되어있지 않다면
			((HttpServletResponse)response).sendRedirect("/dorae/login/login.jsp"); // 로그인 페이지로 리다이렉트
			System.out.println("필터 실행");
			return; // 필터 체인을 타고 내려가지 않게 함수 중지
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	
	
}
