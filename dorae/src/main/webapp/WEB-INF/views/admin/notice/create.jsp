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
	관리자 페이지
	
	<div>
		<form action="create" method="post">
			<p>제목 : <span>${notice.title }</span></p>
			<p>내용 : <textarea>${notice.content }</textarea></p>
			<hr color="red">
			<button type="submit">공지사항 등록</button>
		</form>
	</div>
</body>
</html>