<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/playDetail.css">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
	})//$
	
	$(window).on('load', function() {
		function snsPopup(playName, stageName) {
			console.log("값넘겨주기!!! >>> " + playName + ", " + stageName);
			var url = "../map/sns_share.jsp?playName=" + encodeURIComponent(playName) + "&stageName=" + encodeURIComponent(stageName);
			//var url = "sns_share.jsp?playName=" + encodeURIComponent(playName) + "&stageName=" + encodeURIComponent(stageName)  + "&latitude=" + encodeURIComponent(share_lat)  + "&longitude=" + encodeURIComponent(share_lng);
		    window.open(url, "_blank", "width=500,height=500");
		}
		//공유 아이콘 클릭 이벤트
		$('#infoList').on('click', '.shareIcon', function() {
// 		    var row = $(this).closest('table');
		    var playName = $('#play_id').val();
		    var stageName = $('#stage_id').val();

		    snsPopup(playName, stageName);
		});
	
	})//$
</script>
<style type="text/css">
/* body { */
/* 	display: flex; */
/* 	/* 	width: 1000px; */
/* 	/* 	height: 100px; */
/* } */
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div class="body">

		<h3>공연 상세</h3>
		<hr color="red">
		<div class="container">

			<div class="left-items">
				<img src="${vo.poster}" class="poster"> <a
					href="../seat/one?play_id=${vo.play_id}"><button
						class="reserve">예매</button></a>
			</div>
			<div class="right-items">
				<div id="infoList" class="right-text">
					#${vo.genre_name} #${vo2.stage_name} <br>
					<h1>${vo.play_name}</h1>
					<button class="btnShare">
						<img class='bookIcon' src='../resources/img/icon-book_none.jpg'>
					</button>
					<button class="btnShare">
						<img class='shareIcon' src='../resources/img/icon-share.png'>
					</button>
				</div>
				<div class="right-grade">
					<p style="font-weight: 300; color: #888888;">평점</p>
					<h3>0.0</h3>
				</div>
			</div>

			<!--  </div> -->
			<!-- 			<hr color="red"> -->

		</div>
		<div class="container2">
			<div class="left-items2">
				<div class="left-text2">
					<input id="play_id" type="hidden" value="${vo.play_id}"> <input
						id="stage_name" type="hidden" value="${vo.stage_name}">
					<h3 class="detail">공연 상세</h3>
					<div class="detail">제목 : ${vo.play_name}</div>
					<div class="detail">장르 : ${vo.genre_name} / ${vo.runtime}</div>
					<div class="detail">출연 : ${vo.casting}</div>
					<div class="detail">장소 : ${vo2.stage_name}</div>
					<%-- 					<div>런타임: ${vo.runtime}</div> --%>
					<div class="detail">가격 : ${vo.price}</div>
					<div class="detail">기간 : ${vo.play_start} ~ ${vo.play_end}</div>
					<div class="detail">시간 : ${vo.play_time}</div>
					<div class="detail">등급 : ${vo.play_age}</div>
					<div class="detail">${vo.state}</div>
				</div>
				<div class="review-items">
					<div class="reivew-text">
						<h3>Review</h3>
						<c:if test="${empty listReview}">
							<h5>리뷰가 아직 없습니다.</h5>
						</c:if>
					</div>
					<div class="review-scroll">
						<table>
							<c:forEach items="${listReview}" var="bag">
								<tr>
									<!-- el 속성만 받아올 수 있는 표현식 -->
									<td><div class="nick-name">${bag.nickname}</div></td>
									<td><div class="review-content">${bag.text}</div></td>
								</tr>
							</c:forEach>

						</table>
					</div>
				</div>
			</div>
			<div class="right-items2">
				<!-- 				<h3>공연장 정보</h3> -->
				<!-- 공연장 위치 -->
				<div id="map" class="map"></div>
				<p class="map-stage">${vo2.stage_name}</p>
				<div class="map-detail">좌석: ${vo2.seat_cnt}석</div>
				<div class="map-detail">주소: ${vo2.address}</div>
				<div class="map-detail">번호: ${vo2.tel}</div>
				<div class="map-detail">
					<a href=${vo2.website}>${vo2.website}</a>
				</div>
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