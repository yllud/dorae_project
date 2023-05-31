<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<th>공연id</th>
		<th>공연장id</th>
		<th>공연이름</th>
		<th>공연장르</th>
	</tr>

	<!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
	<c:forEach items="${list}" var="play">
		<tr>
			<td>${play.play_id}</td>
			<td>${play.stage_id}</td>
			<td>${play.play_name}</td>
			<td>${play.genre_name}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>