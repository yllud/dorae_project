<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
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
				<td>${one.created_at}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>${one.content}</td>
			</tr>
		</table>
	</div>
	<a href="../noticeBbs/noticeBbs.jsp"><button>전체목록으로</button></a>
</body>
</html>