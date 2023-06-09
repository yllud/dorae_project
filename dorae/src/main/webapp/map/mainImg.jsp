<!-- mainBanner.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="../resources/js/jquery-3.6.4.js"></script>
<style>
.main-img {
	width: 100%;
	height: 850px;
	position: absolute;
	top: 0;
	left: 0;
}

#imgBody {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 850px;
	z-index: 3;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		// 처음에 이미지 띄우기
		var mainImg = $('<img src="../resources/img/풍경.jpg" class="main-img"/>');
		//var mainImgContainer = $('<div id="ImgBody"></div>');
		$('#imgBody').append(mainImg);

		// 이미지 클릭 이벤트 등록
		$('.main-img').click(function() {
			$('#imgBody').animate({
				opacity : 0
			}, 1000, function() {
				$(this).remove(); // 애니메이션이 끝난 후 요소를 삭제
				// 지도 로드
				//$('#mainBody').load('map.jsp');
			});
		});
	});
</script>
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<div id="mainBody">
		<div id="imgBody"></div>
	</div>

</body>
</html>