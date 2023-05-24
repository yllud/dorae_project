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
	FAQ 페이지
	
	<div>
		<p>제목 : <span>${faq.title }</span></p>
		<p>내용 : <span>${faq.content }</span></p>
		<hr color="red">
	</div>
</body>
</html>