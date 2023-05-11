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
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
<script type="text/javascript" src="../resources/js/MarkerClustering.js"></script>
<script type="text/javascript"
	src="${path}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		// 네이버 지도 API를 로드합니다.
		var map = new naver.maps.Map('map', {
			zoom : 7,
			center : new naver.maps.LatLng(37.5666103, 126.9783882), // 서울 시청을 지도 중심으로 설정
			zoomControl: true,
		    zoomControlOptions: {
	           position: naver.maps.Position.TOP_LEFT,
	           style: naver.maps.ZoomControlStyle.SMALL
	       }
		});
		
		var markers = [];	// Array
		for (var i = 0; i < 100; i++) {
		    var lat = (Math.random() * 2.4) + 35.2; // 대한민국 지역 내에서 랜덤 위도 생성
		    var lng = (Math.random() * 2.3) + 126.8; // 대한민국 지역 내에서 랜덤 경도 생성
		    markers.push(new naver.maps.Marker({
		      position: new naver.maps.LatLng(lat, lng),
		      map: map
		    }));
		  }
		
		var marker1 = {
	            style: "circle",
	            radius: 5,
	            fillColor: "red",
	            fillOpacity: 1,
	            strokeColor: "black",
	            strokeStyle: "solid",
	            strokeWeight: 3
	        }, //서울
	        marker2 = {
	            style: "circle",
	            radius: 15,
	            fillColor: "blue",
	            fillOpacity: 1,
	            strokeColor: "black",
	            strokeStyle: "solid",
	            strokeWeight: 3
	        }, //인천
	        marker3 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../resources/img/cluster-marker-4.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        }, 
	        marker4 = {
	            url: 'http://static.naver.net/maps/img/icons/sp_pins_default_v3_over.png',
	            size: new naver.maps.Size(24, 37),
	            origin: new naver.maps.Point(90, 0),
	            anchor: new naver.maps.Point(12, 37)
	        }, 
	        marker5 = {
	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../resources/img/cluster-marker-5.png);background-size:contain;"></div>',
	            size: N.Size(40, 40),
	            anchor: N.Point(20, 20)
	        }; 

	    var markerClustering = new MarkerClustering({
	        minClusterSize: 2,
	        maxZoom: 13,
	        map: map,
	        markers: markers,
	        disableClickZoom: false,
	        gridSize: 120,
	        icons: [marker1, marker2, marker3, marker4, marker5],
	        indexGenerator: [10, 20, 30, 61, 100],
	        stylingFunction: function(clusterMarker, count) {
	            $(clusterMarker.getElement()).find('div:first-child').text(count);
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