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
	z-index: 9999;
}

#map {
  width: 100%;
  height: 800px;
  z-index: 1;
  position: relative;
}
:root {
  --header-height: 0;
}

</style>
<script type="text/javascript" src="${path}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
<script>
	$(function() {
		$("#header").load("../header.jsp");   
        
        $('#map').load('map.jsp', function(){
        	$('#map').append("<div id='banner'></div>");
        	$('#banner').load("mainBanner.jsp");
        }); 
	})
</script>
<link rel="stylesheet" href="${path}/resources/css/style.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="map"></div>
</body>
</html>
