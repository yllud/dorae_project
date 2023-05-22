<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<style>
#res {
	margin-top: 140px;
}
</style>
<link rel="stylesheet" href="${path}/resources/css/style.css"/>
<script type="text/javascript"
	src="${path}/resources/js/jquery-3.6.4.js"></script>
<script>
	$(document).ready(function() {
		// 처음 화면
		$("#res").load("map/page01_other4.jsp");
		
		/* $.ajax({
			url: "map/page01_other4.jsp", // 해당 JSP 파일 경로로 변경
			type: "GET",
			dataType: "html",
			success: function(response) {
				$("#res").empty();
				$("#res").html(response);
			},
			error: function() {
				alert("요청 실패");
			}
		}); */
		
		$("#menu_search").click(function(e) {
			e.preventDefault();
			// 서버로 해당 JSP 파일 요청하여 내용 가져오기
			$.ajax({
				url: "search/search.jsp", // 해당 JSP 파일 경로로 변경
				type: "GET",
				dataType: "html",
				success: function(response) {
					$("#res").empty();
					$("#res").html(response);
				},
				error: function() {
					alert("요청 실패");
				}
			});
		});
		
		// 태그검색 메뉴 클릭 시
		$("#menu_review").click(function(e) {
			e.preventDefault();
			// 서버로 해당 JSP 파일 요청하여 내용 가져오기
			$.ajax({
				url: "review/reviewBbs.jsp", // 해당 JSP 파일 경로로 변경
				type: "GET",
				dataType: "html",
				success: function(response) {
					$("#res").empty();
					$("#res").html(response);
				},
				error: function() {
					alert("요청 실패");
				}
			});
		});
		
		// 고객센터 메뉴 클릭 시
		$("#menu_help").click(function(e) {
			e.preventDefault();
			// 서버로 해당 JSP 파일 요청하여 내용 가져오기
			$.ajax({
				url: "help/help-test.jsp", // 해당 JSP 파일 경로로 변경
				type: "GET",
				dataType: "html",
				success: function(response) {
					$("#res").empty();
					$("#res").html(response);
				},
				error: function() {
					alert("요청 실패");
				}
			});
		});
		
		// 마이페이지 메뉴 클릭 시
		$("#menu_mypage").click(function(e) {
			e.preventDefault();
			// 서버로 해당 JSP 파일 요청하여 내용 가져오기
			$.ajax({
				url: "sns/sns.jsp", // 해당 JSP 파일 경로로 변경
				type: "GET",
				dataType: "html",
				success: function(response) {
					$("#res").empty();
					$("#res").html(response);
				},
				error: function() {
					alert("요청 실패");
				}
			});
		});
	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><a href="page01.jsp">도래도래</a></h1>
	<div class="menu">
		<nav class="clearfix">
			<ul class="clearfix">
				<!-- <li class="header_li"><a id="menu_search" href="">공연</a></li>
				<li class="header_li"><a id="menu_review" href="">리뷰검색</a></li>
				<li class="header_li"><a id="menu_help" href="">고객센터</a></li>
				<li class="header_li"><a id="menu_mypage" href="">마이페이지</a></li> -->
								
				<li class="header_li"><a href="search/search.jsp">공연</a></li>
				<li class="header_li"><a href="review/reviewBbs.jsp">리뷰검색</a></li>
				<li class="header_li"><a href="help/main">고객센터</a></li> 
				<li class="header_li"><a  href="mypage/main.jsp">마이페이지</a></li>
				
			</ul>
			<a id="pull" href="#"></a>
		</nav>
	</div>
	<div id="res"></div>


</body>
</html>