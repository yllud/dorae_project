<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* body { */
/* 	background: yellow; */
/* } */
td {
	width: 100px;
}

/* .top{ */
/* 	background: black; */
/* 	color:white; */
/* } */
/* .down{ */
/* 	background: lime; */
/* } */
</style>
</head>
<body>
	<table>
		<tr>
			<td><img src="${vo.poster}" width="300" height="300"></td>
		</tr>
		<tr>
			<td>제목 : ${vo.play_name}</td>
		</tr>
		<tr>
			<td>장르: ${vo.genre_name}</td>
		</tr>
		<tr>
			<td>공연장: ${vo.stage_name}</td>
		</tr>
		<tr>
			<td>기간: ${vo.play_start} ~ ${vo.play_end}</td>
		</tr>
		<tr>
			<td>주소: ${vo2.address}</td>
		</tr>
	</table>
</body>
</html>