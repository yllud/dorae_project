<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/shopcss.css">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "playList",
			data : {
				page : 1,
				title : $('#title').val(),
				genre : "전체(장르)",
				state : "공연중"
			},

			success : function(x, genre) {
				$('#result').html(x)
			},//success
			error : function() {
				alert('실패.@@@')
			}//error
		})//ajax

		$('#b0').click(function() {
			//기존의 것 삭제됨.
			$('#result').empty()

			$.ajax({
				url : "playList",
				data : {
					page : 1,
					title : $('#title').val(),
					genre : "전체(장르)",
					state : "공연중"
				},
				success : function(x) {
					$('#result').html(x)
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		})//b0

	})//$
</script>

</head>
<body>
	<div class="filter">
			<h3>공연검색 화면</h3>
			<hr color="red">
			공연제목: <input id="title">
			<button id="b0">검색</button>
			<hr color="red">
	</div>

	<div id="result"></div>
	<!-- 	<div id="result" style="background: yellow"></div> -->


</body>
</html>