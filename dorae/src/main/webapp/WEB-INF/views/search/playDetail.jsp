<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/search.css">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
	})//$
</script>
<style type="text/css">
body {
	display: flex;
	/* 	width: 1000px; */
	/* 	height: 100px; */
}

.container {
	display: flex;
	width: 1200px;
	height: 500px;
/* 	background: #a2d5f2; */
	margin-top:10px;
}

.left-items {
	width: 400px;
	height: 400px;
	/* 	text-align: center; */
	margin-top: 10px;
	margin-left: 0px;
	/* 	background: #ffc93c; */
}

.left-text {
	width: 800px;
	height: 380px;
	/* 	text-align: center; */
	margin-top: 20px;
	margin-left: 10px;
	/* 	background: #ffc93c; */
	font-size: x-large;
}

.left-text-style {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.review-items {
	margin-left: auto;
	/*  	margin-top: 500px; */
	/* 	margin-right: 50px; */
	margin-left: 50px;
	width: 300px;
	height: 300px;
	/* 	text-align: center; */
/* 	background: #ffc93c; */
}

.review-scroll {
	margin-left: auto;
	height: 200px;
	overflow: scroll;
/* 	background: #ffc93c; */
}

.right-items {
	margin-left: auto;
	/*  	margin-top: 500px; */
	/* 	margin-right: 50px; */
	margin-left: 50px;
	width: 300px;
	height: 450px;
	/* 	text-align: center; */
/* 	background: #ffc93c; */
}
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div class="body">

		<h3>공연 상세</h3>
		<hr color="red">
		<div class="container">

			<div class="left-items">
				<img src="${vo.poster}" width="400" height="400">
			</div>
			<div class="left-text">
				<div>제목 : ${vo.play_name}</div>
				<div>장르: ${vo.genre_name}</div>
				<div>출연진: ${vo.casting}</div>
				<div>공연장: ${vo2.stage_name}</div>
				<div>런타임: ${vo.runtime}</div>
				<div>가격: ${vo.price}</div>
				<div>기간: ${vo.play_start} ~ ${vo.play_end}</div>
				<div class="left-text-style">공연 시간: ${vo.play_time}</div>
				<div>${vo.state}</div>
				<div>관람 연령: ${vo.play_age}</div>
				<%-- 				<div>공연장: ${vo.stage_name}</div> --%>
				<div>
					<a href="../seat/one?play_id=${vo.play_id}"><button>예매하기</button></a>
				</div>
			</div>

			<!--  </div> -->
			<!-- 			<hr color="red"> -->

		</div>
		<div class="container">
			<div class="review-items">
				리뷰목록
				<div class="review-scroll">
					<table>
						<c:forEach items="${listReview}" var="bag">
							<tr>
								<!-- el 속성만 받아올 수 있는 표현식 -->
								<td><div class="product-name">${bag.nickname}</div></td>
								<td><div class="product-name1">${bag.text}</div></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="right-items">
				<!-- 				<h3>공연장 정보</h3> -->
				<!-- 공연장 위치 -->
				<div id="map" style="width: 300px; height: 300px;"></div>
				${vo2.stage_name} <br> 좌석: ${vo2.seat_cnt}석 <br> 전화번호:
				${vo2.tel} <br> 싸이트: <a href=${vo2.website}>${vo2.website}</a>
				<br> 주소: ${vo2.address}
			</div>
		</div>

	</div>

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


</body>
</html>