<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 세션 무효화 (로그아웃)
session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
	<%
		out.println("<script type='text/javascript'>alert('로그아웃 되었습니다.');location.href = 'http://localhost:8888/dorae/login/login.jsp'</script>");
	%>
</body>
</html>