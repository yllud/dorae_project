<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<table>
<tr>
<td>${one.tag}</td>
<td>${one.title}</td>
</tr>
<tr>
<td colspan=2>${one.created_at}</td>
</tr>
<tr>
<td colspan=2>${one.content}</td>
</tr>
</table>
</body>
</html>