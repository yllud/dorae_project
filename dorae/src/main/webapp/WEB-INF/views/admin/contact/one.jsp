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
		<form action="updateAnswer" method="post">
			<input value="${vo.contact_id}" name="contact_id" hidden="hidden">
			<p>제목 : <span>${vo.title }</span></p>
			<p>내용 : <span>${vo.content }</span></p>
			<hr color="red">
			<c:if test="${empty vo.answer }">
				<p>
					답변 : <textarea rows="20" cols="30" name="answer"></textarea>
				</p>
				<button type="submit">답변 등록</button>
			</c:if>
			<c:if test="${not empty vo.answer }">
				<p>답변 : <span>${vo.answer }</span></p>
			</c:if>
		</form>
	</div>
</body>
</html>