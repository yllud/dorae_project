<!-- page01.jsp파일 -->
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
	z-index: 100;
}

#map {
  width: 100%;
  height: 850px;
  z-index: 1;
  position: relative;
}
:root {
  --header-height: 0;
}
.main-top-space {
	width: 25%;
  height: 850px;
  position: fixed;
  background-color: white;
  top: 0;
  left: 0;
  right: 0;
  z-index: 100; /* 다른 요소들보다 위에 나타나도록 z-index 설정 */
}
.banner {
  z-index: 9999; /* 다른 요소들보다 위에 나타나도록 z-index 설정 */
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder,drawing,naver.maps.Service"></script>
<script type="text/javascript" src="../resources/js/MarkerClustering.js"></script>
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.4.js"></script>
<script>
	$(function() {
		$("#header").load("../header.jsp");   
        
		$.ajax({
			url : "latLngList",
			success : function(x) {				
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
				for (var i = 0; i < x.length; i++) {
				    var lat = x[i].latitude; // 위도 정보 받아오기
				    var lng = x[i].longitude; // 경도 정보 받아오기
				    
				    marker = new naver.maps.Marker({
				    	position: new naver.maps.LatLng(lat, lng),
		                draggable: true,
		                map: map
		            });
				   	markers.push(marker)
				}	
				
				//geolocation 성공했다면
		        if (navigator.geolocation) {
		            navigator.geolocation.getCurrentPosition(
		                function (position) {
		                    var latitude = position.coords.latitude; // 위도
		                    var longitude = position.coords.longitude; // 경도
		                    map.setCenter(new naver.maps.LatLng(latitude, longitude)); // 기존의 map의 center를 업데이트
		                    map.setZoom(14); // zoom level 업데이트
		                },
		                function (error) {
		                    // 위치 정보를 가져오는데 실패한 경우 처리
		                    console.error("Error occurred. Error code: " + error.code);
		                }
		            );
		        }
				
		        
		     	// infowindow를 생성합니다.
		        var infowindow = new naver.maps.InfoWindow({
		          content: '<div style="padding:10px;">마커 4를 클릭했습니다.</div>'
		        });
		     
				var marker1 = {
			            style: "circle",
			            radius: 5,
			            fillColor: "red",
			            fillOpacity: 1,
			            strokeColor: "black",
			            strokeStyle: "solid",
			            strokeWeight: 3
			        }, 
			        marker2 = {
			            style: "circle",
			            radius: 15,
			            fillColor: "blue",
			            fillOpacity: 1,
			            strokeColor: "black",
			            strokeStyle: "solid",
			            strokeWeight: 3
			        }, 
			        marker3 = {
			            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../resources/img/cluster-marker-4.png);background-size:contain;"></div>',
			            size: N.Size(40, 40),
			            anchor: N.Point(20, 20)
			        }, //묶인 마커의 수
			        marker4 = {
			            url: 'http://static.naver.net/maps/img/icons/sp_pins_default_v3_over.png',
			            size: new naver.maps.Size(24, 37),
			            origin: new naver.maps.Point(90, 0),
			            anchor: new naver.maps.Point(12, 37)
			        }, //네이버 지도 기본 핀 이미지
			        marker5 = {
			            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../resources/img/cluster-marker-5.png);background-size:contain;"></div>',
			            size: N.Size(40, 40),
			            anchor: N.Point(20, 20)
			        }; 
				/*
				  naver.maps.event.addListener(marker4, 'click', function() {
					    var infoWindow = new naver.maps.InfoWindow({
					        content: '<div style="padding:20px;">마커4 클릭입니다!!!</div>',
					        backgroundColor: "#eee",
					        borderColor: "#2db400",
					        borderWidth: 2,
					        anchorSkew: true,
					        anchorColor: "#eee",
					        pixelOffset: new naver.maps.Point(20, -20)
					    });

					    infoWindow.open(map, marker4);
					});
				  */
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
				
			 	// 경로탐색 객체 생성
			    var tmap = new Tmap.Path();

			    // 출발지와 목적지 좌표 설정
			    var start = new naver.maps.LatLng(37.5642135, 126.9746766);
			    var end = new naver.maps.LatLng(37.5666102, 126.9783881);

			    // 경로탐색 요청
			    tmap.route({
			        startName: '출발지',
			        startX: start.lng(),
			        startY: start.lat(),
			        endName: '도착지',
			        endX: end.lng(),
			        endY: end.lat(),
			        searchOption: 'trafast', // 교통정보를 고려한 최적 경로
			        onSuccess: function(result) {
			            // 결과값으로 경로와 거리 정보를 얻을 수 있음
			            var path = result.path;
			            var distance = result.distance;
			            console.log('최단 거리: ' + distance + 'm');
			        },
			        onError: function(error) {
			            console.log('경로탐색 오류');
			        }
			    });
			    
			}
		})
        
        $('#banner').load("mainImg.jsp");
	})
</script>
<link rel="stylesheet" href="${path}/resources/css/style.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="map">
		<div class="main-top-space">
		</div>
		<div id="banner"></div>
	</div>
</body>
</html>
