<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="contentDiv">
	<table>
		<tr>
			<th>북마크no</th>
			<th>이메일</th>
			<th>공연id</th>
		</tr>

		<!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
		<c:forEach items="${list}" var="book">
			<tr>
				<td>${book.book_no}</td>
				<td>${book.email}</td>
				<td>${book.play_id}</td>
			</tr>
		</c:forEach>
	</table>
</div>
