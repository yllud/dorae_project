<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* body { */
/* 	background: yellow; */
/* } */
td {
	width: 100px;
}
</style>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {

		$('#b1').click(function() {
			//기존의 것 삭제됨.


			$.ajax({
				type : "post",
				url : "businessDelete",
				data : {
					play_id:$('#play_id').val()
				},
				success : function(x) {
					alert('공연 삭제 성공')
					window.close()
				},//success
				error : function() {
					alert('삭제 실패')
				}//error
			})//ajax
		})//b1

	})//$
</script>
</head>
<body>
	<h3>공연 상세</h3>
	<!-- el 속성만 받아올 수 있는 표현식 -->
	<input id="play_id" type="hidden" value="${vo.play_id}">
	<img src="${vo.poster}" width="300" height="300">
	<br> 제목 : ${vo.play_name}
	<br> 장르: ${vo.genre_name}
	<br> 공연장: ${vo.stage_name}
	<br> 공연 기간: ${vo.play_start} ~ ${vo.play_end}
	<br> 공연 시간: ${vo.play_time}
	<br> 런타임: ${vo.runtime}
	<br> 관람연령: ${vo.play_age}
	<br> 출연진: ${vo.casting}
	<br> 제작진: ${vo.crew}
	<br> 기업: ${vo.enterprise}
	<br> 가격: ${vo.price}
	<br> 내용:
	<br>
	<textarea id="content" cols="40" rows="8" readonly>${vo.content}</textarea>
	<br> 오픈런: ${vo.openrun}

	<br>
	<hr color="red">
	<form action="businessUpdate" method="post">
		<input type="hidden" name="play_id" value="${vo.play_id}">
		<button onclick="openPopup(); return false;">수정</button>
	</form>
	<button id="b1">삭제</button>

</body>
</html>