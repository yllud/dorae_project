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
	<a href="../seat/one?play_id=${vo.play_id}"><button>예매하기</button></a>

	<hr color="red">
	<h3>공연장 상세</h3>
	${vo2.stage_name}
	<br> 좌석: ${vo2.seat_cnt}석
	<br> 전화번호: ${vo2.tel}
	<br> 싸이트:
	<a href=${vo2.website}>${vo2.website}</a>
	<br> 주소: ${vo2.address}
</body>
</html>