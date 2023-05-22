<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	관리자 페이지
	
	<ul>
	<c:forEach items="${faqList }" var="item">
		<li>
			<span>${item.faq_id } : ${item.help_category_id }</span>
			<a href="one?faq_id=${item.faq_id }">${item.title }</a>
		</li>
	</c:forEach>
	</ul>
	
	<!-- 하단 페이지 버튼 -->
	<div>
		<c:if test="${page.startPage != 1 }">
			<a href="?help_category_id=${help_category_id }&page=${page.startPage - 1 }">&lt;</a>
		</c:if>
		
		<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
			<a href="?help_category_id=${help_category_id }&page=${p }">${p }</a>
		</c:forEach>
		
		<c:if test="${page.endPage != page.lastPage}">
			<a href="?help_category_id=${help_category_id }&page=${page.endPage+1 }">&gt;</a>
		</c:if>
	</div>
</body>
</html>