<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:forEach var="item" items="${list}">
	<a href="${item.link}" target="_blank">
	<div
		style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">
		<h3>${item.title}</h3>
		<p>${item.description}</p>
		<p>${item.bloggername}</p>
		<p>${item.bloggerlink}</p>
		<p>${item.postdate}</p>
		
	</div>
	</a>
</c:forEach> --%>


<div class="blog-list">
  <c:forEach var="item" items="${list}">
    <a href="${item.link}" target="_blank" class="blog-link">
      <div class="blog-item">
        <h3 class="blog-title">${item.title}</h3>
        <p class="blog-description">${item.description}</p>
        <p class="blog-bloggername">${item.bloggername}</p>
        <p class="blog-bloggerlink">${item.bloggerlink}</p>
        <p class="blog-postdate">${item.postdate}</p>
      </div>
    </a>
  </c:forEach>
</div>