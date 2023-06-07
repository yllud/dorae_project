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
				title : $('#inputSearch').val(),
				genre : "전체(장르)",
				state : "공연중",
				district : "전체(지역)"
			},

			success : function(x) {

				$('#result').html(x)
				
				var $x = $(x); // x를 jQuery 객체로 변환

				var div2 = $x.filter('.ranking0'); // 클래스가 'class2'인 div 선택

				$('#resultRank').append(div2);
				$('#ranking0').empty();

			},//success
			error : function() {
				alert('실패.@@@')
			}//error
		})//ajax

		function searchPlayList() {
			//기존의 것 삭제됨.
			// 			$('#result').empty()

			$.ajax({
				url : "playList",
				data : {
					page : 1,
					title : $('#inputSearch').val(),
					genre : "전체(장르)",
					state : "공연중",
					district : "전체(지역)"
				},
				success : function(x) {
					$('#result').html(x)
					$('#ranking0').empty();
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		}

		//버튼 눌러서 입력
		$('#BtnSearch').click(function() {
			// 기존의 것 삭제됨.
			$('#result').empty();

			searchPlayList();
		});

		//enter 키로 입력
		$('#inputSearch').keypress(function(event) {
			if (event.keyCode === 13) {
				searchPlayList();
			}
		});

	})//$
</script>



</head>
<body>

	<header id="header" class="fixed-top"></header>
	<div class="container">
		<div class="body0">
			<!-- 세션에 user_type이 business면 버튼을 보여주자!(사업자 페이지) -->
<%-- 			<input value="<%=session.getAttribute("user_type")%>"> --%>
<%-- 			<input value="<%=session.getAttribute("email")%>"> --%>

<%-- 			<% --%>
<!--  				String userType = (String) session.getAttribute("user_type"); -->
<!--  				if (userType != null && userType.equals("business")) { -->
<%-- 			%> --%>
<!-- 			<form action="../search/business" method="post" target="_blank"> -->
<!-- 				<button>사업자 페이지</button> -->
<!-- 			</form> -->
<%-- 			<% --%>
<!--  				} -->
<%-- 			%> --%>

			<!-- 		<h3 style="margin-left: 75px">공연검색</h3> -->
			<div class="filter">
				<div class="filter1">
					<input id="inputSearch" type="search" placeholder="공연명, 공연장, 출연진 ">
					<span class="clearButton">&#x2716;</span>
					<button id="BtnSearch">검색</button>
				</div>

			</div>

			<div id="result"></div>


		</div>
		<div id="resultRank" class="rank0"></div>
	</div>

</body>
</html>