<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<td>번호</td>
			<td>공연 제목</td>
		</tr>
		<c:forEach items="${list2}" var="vo">
			<tr>
				<td>${vo.rownum }</td>
				<td>${vo.play_name}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>