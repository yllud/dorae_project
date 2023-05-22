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
	관리자 로그인 페이지

	<form action="login" method="post">
		<input name="id"/><br>
		<input type="password" name="password"/><br>
		<button type="submit">로그인</button>
	</form>
</body>
</html>