<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>검색된 태그 : ${tag}</h3>
<h3>검색된 review 글 count: ${count}</h3>
<hr color="red">
<%
	int pages = (int)request.getAttribute("pages");
	for(int p = 1; p <= pages; p++){
%>
	<a href="tagSearch?page=<%= p %>&tag=${tag}">
		<button style="background: lime; color: red; width: 50px;"><%= p %></button>
	</a>  
<%		
	}
%>
<div>
	<h1>후기 목록</h1>
	<c:choose>
		<c:when test="${not empty list}">
			<c:forEach var="review" items="${list}">
				<div>
					<h3>제목: ${review.title}</h3>
					<p>내용: ${review.content}</p>
					<p>태그: ${review.tag}</p>
					<c:if test="${not empty review.images}">
						<c:forEach var="image" items="${review.images}">
							<img src="../resources/upload/${image}" alt="후기 이미지" width="300"
								height="300" />
						</c:forEach>
					</c:if>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<p>후기가 없습니다.</p>
		</c:otherwise>
	</c:choose>
</div>