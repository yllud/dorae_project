<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	FAQ 등록 페이지
	
	<div>
		<form action="create" method="post">
			<p>제목 : <input name="title" /></p>
			<p>내용 : <input name="content" /></p>
			<hr color="red">
			<button type="submit">FAQ 등록</button>
		</form>
	</div>
</body>
</html>