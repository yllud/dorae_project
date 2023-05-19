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
</body>
</html>