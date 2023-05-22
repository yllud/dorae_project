<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 가입 페이지</title>
</head>
<body>
	관리자 가입 페이지

	<form action="join" method="post">
		<input name="id"/><br>
		<input type="password" name="password"/><br>
		<input name="name"/><br>
		<input name="nickname"/><br>
		<button type="submit">가입</button>
	</form>
</body>
</html>