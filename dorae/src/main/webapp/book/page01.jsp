<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
#header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 9999;
}

#map {
  width: 100%;
  z-index: 1;
}
:root {
  --header-height: 0;
}
</style>
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.4.js"></script>
<script>
	$(function() {
		$("#header").load("../header.jsp");
		  
		$.ajax({
			url : "https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder",
			dataType : "script",
			success : function() {
				var mapOptions = {
					zoom : 10
				};
				var map = new naver.maps.Map('map', mapOptions);

				var geocoder = new naver.maps.services.Geocoder(
						{
							clientId : 'uez2akrxoe',
							clientSecret : 'pm8Fc6KwTQrHR0QRtJPEFJFYaUiDsCBLgmwmZ0fK'
						});

				// HTML5 Geolocation API를 사용하여 현재 위치를 얻어옴
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(function(
							position) {
						var lat = position.coords.latitude;
						var lng = position.coords.longitude;

						// 현재 위치에 마커 추가
						var marker = new naver.maps.Marker({
							position : new naver.maps.LatLng(lat, lng),
							map : map
						});

						// 현재 위치로 지도 이동
						map.setCenter(new naver.maps.LatLng(lat, lng));
					}, function() {
						alert('위치 정보를 가져올 수 없습니다.');
					});
				} else {
					alert('이 브라우저는 Geolocation을 지원하지 않습니다.');
				}

				var address = '서울특별시 종로구 세종로 사직로 161';
				geocoder.addressToCoord(address, function(status,
						response) {
					if (status === naver.maps.Service.Status.ERROR) {
						alert('주소를 찾을 수 없습니다.');
						return;
					}
					var marker = new naver.maps.Marker({
						position : new naver.maps.LatLng(
								response.result.items[0].point.y,
								response.result.items[0].point.x),
						map : map
					});
				});
			}
		});
	})
</script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
<link rel="stylesheet" href="${path}/resources/css/style.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="map" style="width: 100%; height: 900px;"></div>
	<section>
		<div id="result"></div>
	</section>
</body>
</html>