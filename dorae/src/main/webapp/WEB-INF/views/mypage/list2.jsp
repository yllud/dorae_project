<%@page import="com.multi.dorae.mypage.ReplyVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background: yellow;
}

td {
	width: 100px;
	text-align: center;
}

.top {
	background: black;
	color: white;
}

.down {
	background: lime;
}
</style>
</head>
<body>
	<table>
		<tr>
			<td class="top">r_number</td>
			<td class="top">text</td>
			<td class="top">booking</td>
			<td class="top">date</td>
			<td class="top">imp_uid</td>
			<td class="top">upload_date</td>
		</tr>

		<c:forEach items="${list}" var="bag"> 

<tr>
				<td class="down">${bag.email}</td>
				<td class="down"><a href="../mypage/one2?email=${bag.email}">${bag.text}</a>
				</td>
				<td class="down">${bag.booking}</td>
				<td class="down">${bag.date}</td>
				<td class="down">${bag.imp_uid}</td>
				<td class="down">${bag.upload_date}</td>
			</tr>

		</c:forEach>
	</table>
</body>
</html>