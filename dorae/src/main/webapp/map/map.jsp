<!-- map.jsp파일 -->
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
  z-index: 2;
}
:root {
  --header-height: 0;
}
</style>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // 네이버 지도 API를 로드합니다.
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.5666103, 126.9783882), // 서울 시청을 지도 중심으로 설정합니다.
            zoom: 10 // 지도의 확대/축소 레벨을 설정합니다.
        });

        // 마커를 생성합니다.
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(37.5666103, 126.9783882), // 마커의 위치를 설정합니다.
            map: map // 마커를 지도에 표시합니다.
        });
        
    	// 지도의 줌 레벨을 조정하여 자동으로 줌되도록 합니다.
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