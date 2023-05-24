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
		<p>아이디 : <input name="id"/></p>
		<p>비밀번호 : <input type="password" name="password"/></p>
		<p>이름 : <input name="name"/></p>
		<p>닉네임 : <input name="nickname"/></p>
		<button type="submit">가입</button>
	</form>
</body>
</html>