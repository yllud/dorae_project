<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/style.css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
    // JavaScript 코드
    window.addEventListener('DOMContentLoaded', function () {
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
	<h1><a href="page01.jsp">도래도래</a></h1>
	<div class="menu">
		<nav class="clearfix">
			<ul class="clearfix">
				<!-- <li class="header_li"><a id="menu_search" href="">공연</a></li>
				<li class="header_li"><a id="menu_review" href="">리뷰검색</a></li>
				<li class="header_li"><a id="menu_help" href="">고객센터</a></li>
				<li class="header_li"><a id="menu_mypage" href="">	마이페이지</a></li> -->
								
				<li class="header_li"><a href="search/search.jsp">공연</a></li>
				
				<div class="dropdown">
					<li class="header_li"><a href="review/reviewBbs.jsp">커뮤니티</a></li>
						<div class="dropdown-content">
							<a href="review/reviewBbs.jsp">다녀온 후기</a>
							<a href="sns/sns.jsp">SNS추천</a>
							<a href="review/reviewBbs.jsp">공지사항</a>
						</div>
				</div>
					
				<li class="header_li"><a href="help/main">고객센터</a></li> 
				<li class="header_li"><a  href="mypage/main.jsp">마이페이지</a></li>
				
			</ul>
			<a id="pull" href="#"></a>
		</nav>
	</div>
	<div id="res"></div>

</body>
</html>