package com.multi.dorae.admin;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

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

@WebFilter("/admin/*")
public class AdminFilter implements Filter{
	
	private final Set<String> url = new HashSet<String>();
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// 해당 url는 비로그인만 접속 가능
		url.add("/dorae/admin/login");
		url.add("/dorae/admin/join");
		url.add("/dorae/admin/find");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		
		// 비로그인이고, 로그인이 필요한 url 요청 시에
		// 로그인이고, 로그인이 필요하지 않은 url 요청 시에
		if ((session.getAttribute("admin") == null) != (url.contains(httpRequest.getRequestURI()))) {
			if (session.getAttribute("admin") != null) { // 로그인 일 때
				httpResponse.sendRedirect("/dorae/admin");
				return;
			}
			if (httpRequest.getRequestURI().equals("/dorae/admin")) {	// 비로그인이고 메인 페이지를 요청할 때
				httpResponse.sendRedirect("/dorae/admin/login");				
			} else {													// 비로그인이고 상세 페이지를 요청할 때
				httpResponse.addHeader("invalidated", "/dorae/admin/login");
			}
			return;
		}
		
		chain.doFilter(request, response);
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	
}
