<!-- map.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
#map {
	width: 100%;
	z-index: 2;
}
</style>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
<script type="text/javascript"
	src="${path}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		// 네이버 지도 API를 로드합니다.
		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(37.5666103, 126.9783882), // 서울 시청을 지도 중심으로 설정합니다.
			zoom : 10
		// 지도의 확대/축소 레벨을 설정합니다.
		});

		/*var markerOptions = {
		 position : new naver.maps.LatLng(37.5666103, 126.9783882),
		 map : map
		 };
		 */
		//var marker = new naver.maps.Marker(markerOptions);
		//book/LatLngList에서 위도, 경도값을 받아옴
		//map.jsp파일
		$.ajax({
			type : "GET",
			url : "book/LatLngList",
			dataType : "text", // JSON 대신 text로 받아옴
			success : function(data) {
				console.log(data); // 받아온 데이터 출력
				var latLngList = JSON.parse(data); // JSON 형식으로 파싱
				console.log(data);
				// latLngList를 이용하여 지도에 마커를 추가
				for (var i = 0; i < latLngList.length; i++) {
					var lat = latLngList[i].lat;
					var lng = latLngList[i].lng;

					var marker = new naver.maps.Marker({
						position : new naver.maps.LatLng(lat, lng),
						map : map
					});
				}
				// 마지막 마커의 위치를 기준으로 지도를 이동
				map.panTo(marker.getPosition());
				// 지도의 줌 레벨을 조정하여 자동으로 줌인
				map.setZoom(15);
			},
			error : function() {
				alert('검색 실패');
				console.log("검색 실패!");
			}
		});
	});
</script>
<link rel="stylesheet" href="${path}/resources/css/style.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<div id="map" style="width: 100%; height: 800px;"></div>
</body>
</html>