<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
<link rel="stylesheet" href="../resources/css/noticeBbs.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {
		$("#header").load("../header/header.jsp");
		// 페이지 로드 시

		$.ajax({
			url : "notice",
			data : {
				tag : "공지사항"
			},
			success : function(result) {
				$('#notice').html(result);
			},
			error : function(xhr, status, error) {
				alert('에러 발생');
			}
		})

		$.ajax({
			url : "event",
			data : {
				page : 1,
				tag : "이벤트"
			},
			success : function(result) {
				$('#event').html(result);
			},
			error : function(xhr, status, error) {
				alert('에러 발생');
			}
		})

	})
</script>

</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="top"><h1>이벤트</h1><hr color="#ff9900"></div>
	<div id="noticeBbs">
		<div id="background">
			<div id="result">
				<div id="notice"></div>
				<div id="event"></div>
			</div>
		</div>
	</div>
</body>
</html>