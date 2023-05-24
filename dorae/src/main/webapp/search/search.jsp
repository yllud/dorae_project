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
		$("#header").load("../header/header.jsp");
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
	<header id="header" class="fixed-top"></header>

	<!-- 세션에 user_type이 business면 버튼을 보여주자!(사업자 페이지) -->
	<input value="<%=session.getAttribute("user_type")%>">
	<input value="<%=session.getAttribute("email")%>">
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