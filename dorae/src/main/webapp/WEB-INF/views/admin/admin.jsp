<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	관리자 페이지

	<p>
		<a href="admin/contact/list?page=1">1:1 문의 목록 </a>
	</p>
	<p>
		<a href="admin/faq/list?help_category_id=D01&page=1">FAQ 목록</a>
	</p>
	<p>
		<a href="admin/notice/list?page=1">공지사항 목록</a>
	</p>
</body>
</html>