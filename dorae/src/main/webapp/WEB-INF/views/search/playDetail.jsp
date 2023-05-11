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
	<h3>공연장 정보</h3>
	${vo2.stage_name}
	<br> 좌석: ${vo2.seat_cnt}석
	<br> 전화번호: ${vo2.tel}
	<br> 싸이트:
	<a href=${vo2.website}>${vo2.website}</a>
	<br> 주소: ${vo2.address}

	<!-- 공연장 위치 -->
	<div id="map" style="width: 350px; height: 350px;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c86d97abbc1c8a6096906791ce94735"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(${vo2.latitude}, ${vo2.longitude}), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(${vo2.latitude}, ${vo2.longitude});

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);
	</script>
	
	<hr color="red">
	리뮤 목록~
</body>
</html>