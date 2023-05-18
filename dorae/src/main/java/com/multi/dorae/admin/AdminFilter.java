package com.multi.dorae.admin;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter("/admin/*")
public class AdminFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest hsr = (HttpServletRequest) request;
		System.out.println("admin session : " + hsr.getSession());

		chain.doFilter(request, response);
//		((HttpServletResponse)response).sendRedirect("../help/help.jsp"); //리다이렉트
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	
}
