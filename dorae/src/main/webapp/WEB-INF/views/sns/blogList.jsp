<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="item" items="${list}">
		<div
			style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">
			<h3>${item.title}</h3>
			<p>${item.description}</p>
			<a href="${item.link}">${item.link}</a>
		</div>
	</c:forEach>

</body>
</html>