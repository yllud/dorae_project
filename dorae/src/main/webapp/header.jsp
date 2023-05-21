<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/style.css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><a href="page01.jsp">도래도래</a></h1>
	<div class="menu">
		<nav class="clearfix">
			<ul class="clearfix">
				<li class="header_li"><a href="search/search.jsp">공연</a></li>
				<li class="header_li"><a href="">태그검색</a></li>
				<li class="header_li"><a href="">고객센터</a></li>
				<li class="header_li"><a href="">마이페이지</a></li>
			</ul>
			<a id="pull" href="#"></a>
		</nav>
	</div>


</body>
</html>