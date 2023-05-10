<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>게시글 전체검색</h2>
<table>
<tr id="t1">
<th>no</th>
<th>email</th>
<th>play_id</th>
</tr>
<c:forEach var="bag" items="${list}">
<tr>
<td>${bag.book_no}</td>
<td>${bag.email}</a></td>
<td>${bag.play_id}</td>
</tr>
</c:forEach>

</table>
</body>
</html>