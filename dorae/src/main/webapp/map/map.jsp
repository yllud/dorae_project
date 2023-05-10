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
		/*
		// playList에서 play_id 값을 받아옴
		$.ajax({
		    type : "GET",
		    url : "${path}/playList",
		    success : function(data) {
		        var stage_id = data.stage_id
		    },
		    error : function() {
		        // 코드 생략
		    }
		});// stage_id 값을 받아올 코드를 작성

		// AJAX 요청을 보냅니다.
		$.ajax({
			type : "GET",
			url : "${path}/playDetail",
			data : {
				stage_id : stage_id
			},
			success : function(data) {
				// 요청이 성공하면 success 콜백 함수가 실행됩니다.
				// 받아온 데이터를 이용하여 마커를 생성하는 코드를 추가합니다.
				var latlngBounds = new naver.maps.LatLngBounds();
		        for (var i = 0; i < data.length; i++) {
		            var latlng = new naver.maps.LatLng(data[i].latitude, data[i].longitude);
		            var marker = new naver.maps.Marker({
		                position: latlng,
		                map: map
		            });
		            latlngBounds.extend(latlng);
		        }
		        map.fitBounds(latlngBounds);
			},
			error : function() {
				// 요청이 실패하면 error 콜백 함수가 실행됩니다.
				alert("AJAX 요청이 실패하였습니다.");
			}
		});
		*/
		
		var stage_id;
		$.ajax({
		    type: "GET",
		    url: "${path}/search/getStageIds",
		    success: function(data) {
		        stage_id = data[1]; // stage_id로 사용할 첫 번째 값을 받아옴.
		        
		     // stage_id를 이용하여 해당 공연장의 위치 정보를 가져오는 AJAX 요청을 보냄.
		        $.ajax({
		            type: "GET",
		            url: "${path}/search/playDetail",
		            data: {
		                "stage_id": stage_id
		            },
		            success: function(data) {
		                var latitude = data.latitude;
		                var longitude = data.longitude;
		                
		             	// latitude와 longitude 값을 이용하여 마커를 생성
		                var marker = new google.maps.Marker({
		                    position: {lat: latitude, lng: longitude},
		                    map: map,
		                    title: vo2.stage_name
		                });
		            },
		            error: function() {
		                alert("AJAX 요청이 실패하였습니다.");
		            }
		        });
		    },
		    error: function() {
		        alert("AJAX 요청이 실패하였습니다.");
		    }
		});
		// 지도의 줌 레벨을 조정하여 자동으로 줌인
		map.setZoom(15);
		map.panTo(marker.getPosition());
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