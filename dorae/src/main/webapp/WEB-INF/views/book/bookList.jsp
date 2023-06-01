<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="contentDiv">
	<table>
		<tr>
			<th>공연포스터</th>
			<th>공연이름</th>
			<th>장르이름</th>
			<th>공연장이름</th>
		</tr>
		<!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
		<c:forEach items="${list2}" var="list">
			<tr>
				<td>${list.poster}</td>
				<td>${list.play_name}</td>
				<td>${list.genre_name}</td>
				<td>${book.stage_name}</td>
			</tr>
		</c:forEach>
	</table>
</div>
