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
<script type="text/javascript" src="${path}/resources/js/MarkerClustering.js"></script>
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
		for (var i = 0; i < 300; i++) {
		    var lat = (Math.random() * 2.4) + 35.2; // 대한민국 지역 내에서 랜덤 위도 생성
		    var lng = (Math.random() * 2.3) + 126.8; // 대한민국 지역 내에서 랜덤 경도 생성
		    markers.push(new naver.maps.Marker({
		      position: new naver.maps.LatLng(lat, lng),
		      map: map
		    }));
		  }
		
		var markerOptions = {
			position : new naver.maps.LatLng(37.5666103, 126.9783882),
		 	map : map
		};
		
		var marker = new naver.maps.Marker(markerOptions);
		
		var htmlMarker1 = {
		        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/img/cluster-marker-1.png);background-size:contain;"></div>',
		        size: N.Size(40, 40),
		        anchor: N.Point(20, 20)
		    },
		    htmlMarker2 = {
		        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/img/cluster-marker-2.png);background-size:contain;"></div>',
		        size: N.Size(40, 40),
		        anchor: N.Point(20, 20)
		    },
		    htmlMarker3 = {
		        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/img/cluster-marker-3.png);background-size:contain;"></div>',
		        size: N.Size(40, 40),
		        anchor: N.Point(20, 20)
		    },
		    htmlMarker4 = {
		        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/img/cluster-marker-4.png);background-size:contain;"></div>',
		        size: N.Size(40, 40),
		        anchor: N.Point(20, 20)
		    },
		    htmlMarker5 = {
		        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/img/cluster-marker-5.png);background-size:contain;"></div>',
		        size: N.Size(40, 40),
		        anchor: N.Point(20, 20)
		    };

		function onLoad() {
		    var data = accidentDeath.searchResult.accidentDeath;

		    for (var i = 0, ii = data.length; i < ii; i++) {
		        var spot = data[i],
		            latlng = new naver.maps.LatLng(spot.grd_la, spot.grd_lo),
		            marker = new naver.maps.Marker({
		                position: latlng,
		                draggable: true
		            });

		        markers.push(marker);
		    }

		    var markerClustering = new MarkerClustering({
		        minClusterSize: 2,
		        maxZoom: 8,
		        map: map,
		        markers: markers,
		        disableClickZoom: false,
		        gridSize: 120,
		        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
		        indexGenerator: [10, 100, 200, 500, 1000],
		        stylingFunction: function(clusterMarker, count) {
		            $(clusterMarker.getElement()).find('div:first-child').text(count);
		        }
		    });
		}
		
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