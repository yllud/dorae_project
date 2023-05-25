<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/search.css">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
		$.ajax({
			url : "playList",
			data : {
				page : 1,
				title : $('#title').val(),
				genre : "전체(장르)",
				state : "공연중",
				district: "전체(지역)"
			},

			success : function(x) {
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
					state : "공연중",
					district : "전체(지역)"
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

<style type="text/css">
body {
	display: flex;
	/* 	width: 1000px; */
	/* 	height: 100px; */
}
</style>

</head>
<body>

	<header id="header" class="fixed-top"></header>
	<div class="body">
		<!-- 세션에 user_type이 business면 버튼을 보여주자!(사업자 페이지) -->
		<input value="<%=session.getAttribute("user_type")%>" type="hidden">
		<input value="<%=session.getAttribute("email")%>" type="hidden">
		<%
			String userType = (String) session.getAttribute("user_type");

			if (userType != null && userType.equals("business")) {
		%>
		<form action="../search/business" method="post">
			<button>사업자 페이지로</button>
		</form>

		<%
			}
		%>

		<h3 style="margin-left: 75px">공연검색</h3>
		<div class="filter">

			<hr color="red">
			공연제목: <input id="title">
			<button id="b0">검색</button>
<!-- 			<hr color="red"> -->
		</div>

		<div id="result"></div>
		<!-- 	<div id="result" style="background: yellow"></div> -->
	</div>

</body>
</html>