<!-- test.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 지도와 목록 탭</title>
<style>
#map {
	width: 100%;
	height: 400px;
}

#tab-container {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
}

.tab {
	padding: 10px;
	border: 1px solid #ccc;
	cursor: pointer;
}

.tab.active {
	background-color: #ccc;
}

#list-container {
	margin-top: 20px;
}

.list-item {
	padding: 10px;
	border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>
	<div id="map"></div>

	<div id="tab-container">
		<div class="tab active" onclick="showList('restaurant')">레스토랑</div>
		<div class="tab" onclick="showList('cafe')">카페</div>
		<div class="tab" onclick="showList('hotel')">호텔</div>
	</div>

	<div id="list-container">
		<div class="list-item restaurant">레스토랑 1</div>
		<div class="list-item restaurant">레스토랑 2</div>
		<div class="list-item restaurant">레스토랑 3</div>
		<div class="list-item cafe">카페 1</div>
		<div class="list-item cafe">카페 2</div>
		<div class="list-item cafe">카페 3</div>
		<div class="list-item hotel">호텔 1</div>
		<div class="list-item hotel">호텔 2</div>
		<div class="list-item hotel">호텔 3</div>
	</div>

	<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
	<script>
		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(37.5665, 126.9780),
			zoom : 13
		});

		function showList(category) {
			// 모든 리스트 아이템을 숨김
			var listItems = document.getElementsByClassName('list-item');
			for (var i = 0; i < listItems.length; i++) {
				listItems[i].style.display = 'none';
			}

			// 해당 카테고리의 리스트 아이템을 보여줌
			var categoryItems = document.getElementsByClassName(category);
			for (var i = 0; i < categoryItems.length; i++) {
				categoryItems[i].style.display = 'block';
			}

			// 탭 활성화 처리
			var tabs = document.getElementsByClassName('tab');
			for (var i = 0; i < tabs.length; i++) {
				tabs[i].classList.remove('active');
			}
			event.target.classList.add('active');
		}
	</script>
</body>