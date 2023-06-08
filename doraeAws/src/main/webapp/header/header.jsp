<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
.logo a {
	display: block;
	font-size: 40px;
	padding: 20px;
	padding-bottom: 0;
}
</style>
<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/style.css" />
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// JavaScript 코드
	$(window).on('load', function() {
		var menuItems = document.querySelectorAll('.menu-item');
		menuItems.forEach(function(menuItem) {
			var submenu = menuItem.querySelector('.submenu');
			menuItem.addEventListener('mouseover', function() {
				submenu.style.display = 'block';
			});
			menuItem.addEventListener('mouseout', function() {
				submenu.style.display = 'none';
			});
		});

	});

	function submitForm(event, element) {
		event.preventDefault();
		element.closest("form").submit();
	}
	
	function go() {
		//alert(window.location.href)
		let before = window.location.href
		$.ajax({
			url: '/dorae/login/before',
			data: {
				before: before
			},
			success: function() {
				//alert('이전 주소 세션 추가 ')
			},
			error: function(e) {
				alert(e)
			}
		})
		location.href='../login/login.jsp'
	}
</script>
</head>
<body>
	<div class="logo">
		<a href="../map/main.jsp"><b>도래도래</b></a>
	</div>
	<h4 style="margin: 10px; margin-top: 0; text-align: right">
		<!-- 마이페이지 클릭 시 경로 수정필요!! -->
		<%
			if (session.getAttribute("email") != null) {
		%>
		<a style="font-weight: bold; font-size: 20px;"><%=session.getAttribute("nickname")%>님</a>
		<%
			String userType = (String) session.getAttribute("user_type");
				if (userType != null && userType.equals("business")) {
		%>
		<form action="../search/business" method="post" target="_blank"
			style="display: inline-block;">
			<a href="#" onclick="submitForm(event, this);"
				style="font-weight: bold; font-size: 20px;">사업자 페이지 </a>
		</form>
		<%
			}
		%> | 
		<a id="loginBtn" href="../login/mypage"
			style="font-weight: bold; font-size: 20px;">마이페이지</a> | <a id="logout" href='../login/logout.jsp'
			style="font-weight: bold; font-size: 20px;">로그아웃</a>

		<%
			} else {
		%>
		<a href="#" onclick="go()" style="font-weight: bold; font-size: 20px;">로그인/회원가입</a>
		<%
			}
		%>
	</h4>
	<div class="menu">
		<nav class="header_nav">
			<ul class="header_ul">
				<li class="header_li"><a href="../map/main.jsp">추천</a></li>
				<li class="header_li"><a href="../search/search.jsp">공연</a></li>

				<div class="dropdown">
					<li class="header_li"><a href="../review/reviewBbs.jsp">커뮤니티</a></li>
					<div class="dropdown-content">
						<a href="../review/reviewBbs.jsp">다녀온 후기</a> <a
							href="../sns/sns.jsp">SNS 후기</a> <a
							href="../noticeBbs/noticeBbs.jsp">이벤트</a>
					</div>
				</div>
				<li class="header_li"><a href="../help/main">고객센터</a></li>


			</ul>
			<a id="pull" href="#"></a>
		</nav>
	</div>
	<div id="res"></div>
</body>
</html>