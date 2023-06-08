<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트/공지사항 상세페이지</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
	<div id="detail">
	<a href="../noticeBbs/noticeBbs.jsp"><button id="total">전체목록으로</button></a>
	<br><br>
		<table>
			<tr class="detail-title">
				<td id="tag-td">${one.tag}</td>
				<td id="title-td">${one.title}</td>
			</tr>
			<tr class="detail-date">
				<td id= "date-td" colspan=2><fmt:timeZone value="GMT"><fmt:formatDate value="${one.created_at}" pattern="yyyy-MM-dd"/></fmt:timeZone></td>
			</tr>
			<tr class="detail-content">
				<td id="content-td" colspan=2>${one.content}</td>
			</tr>
		</table>
	</div>
</body>
</html>