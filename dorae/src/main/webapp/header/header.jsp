<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
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
<link rel="stylesheet" href="../resources/css/style.css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
    // JavaScript 코드
    $(window).on('load', function() {
        var menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(function (menuItem) {
            var submenu = menuItem.querySelector('.submenu');
            menuItem.addEventListener('mouseover', function () {
                submenu.style.display = 'block';
            });
            menuItem.addEventListener('mouseout', function () {
                submenu.style.display = 'none';
            });
        });
    });
</script>
</head>
<body>
	<div class="logo"><a href="../map/main.jsp"><b>도래도래</b></a></div>
	<h4 style="margin:10px; margin-top:0; text-align: right"><a href="../login/login.jsp">로그인/회원가입</a></h4>
	<div class="menu">
		<nav class="clearfix">
			<ul class="clearfix">								
				<li class="header_li"><a  href="../map/main.jsp">추천</a></li>
				<li class="header_li"><a href="../search/search.jsp">공연</a></li>
				
				<div class="dropdown">
				<li class="header_li"><a href="../review/reviewBbs.jsp">커뮤니티</a></li>
					<div class="dropdown-content">
						<a href="../review/reviewBbs.jsp">다녀온 후기</a>
						<a href="../sns/sns.jsp">SNS추천</a>
						<a href="../noticeBbs/noticeBbs.jsp">공지사항</a>
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