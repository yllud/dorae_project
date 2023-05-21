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
	<c:forEach items="${contactList }" var="item">
		<li>
			<span>${item.member_id } : ${item.created_at }</span>
			<a href="one?contact_id=${item.contact_id }">${item.title }</a>
			<c:if test="${empty item.admin_id }">
			<span>답변 미완료</span>
			</c:if>
			<c:if test="${not empty item.admin_id }">
			<span>답변 완료</span>
			</c:if>
		</li>
	</c:forEach>
	</ul>
	
	<!-- 하단 페이지 버튼 -->
	<div>
		<c:if test="${page.startPage != 1 }">
			<a href="?page=${page.startPage - 1 }">&lt;</a>
		</c:if>
		
		<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
			<a href="?page=${p }">${p }</a>
		</c:forEach>
		
		<c:if test="${page.endPage != page.lastPage}">
			<a href="?page=${page.endPage+1 }">&gt;</a>
		</c:if>
	</div>
</body>
</html>