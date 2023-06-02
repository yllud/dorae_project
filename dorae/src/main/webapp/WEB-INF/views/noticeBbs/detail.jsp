<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트/공지사항 상세페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("/dorae/header/header.jsp");
	})
</script>
<style>
#detail {
	margin-top: 175px;
}
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="detail">
		<table>
			<tr>
				<td>분류</td>
				<td>${one.tag}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${one.title}</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><fmt:timeZone value="GMT"><fmt:formatDate value="${one.created_at}" pattern="yyyy-MM-dd"/></fmt:timeZone></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${one.content}</td>
			</tr>
		</table>
	</div>
	<a href="/dorae/noticeBbs/noticeBbs.jsp"><button>전체목록으로</button></a>
</body>
</html>