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
	<h3>공연 상세</h3>
	<!-- el 속성만 받아올 수 있는 표현식 -->
	<img src="${vo.poster}" width="300" height="300">
	<br> 제목 : ${vo.play_name}
	<br> 장르: ${vo.genre_name}
	<br> 출연진: ${vo.casting}
	<br> 기간: ${vo.play_start} ~ ${vo.play_end}
	<br> 공연 상태: ${vo.state}
	<br> 공연장: ${vo.stage_name}
	<br>
	<hr color="red">
	<a href="#"><button>수정</button></a>
	<a href="#"><button>삭제</button></a>
	
	
	
</body>
</html>