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
	공지사항 페이지
	
	<div>
		<p>번호 : <span>${notice.notice_id }</span></p>
		<p>제목 : <span>${notice.title }</span></p>
		<p>내용 : <span>${notice.content }</span></p>
		<p>작성일 : <span>${notice.created_at }</span></p>
		<p>태그 : <span>${notice.tag }</span></p>
		<hr color="red">
	</div>
</body>
</html>