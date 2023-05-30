<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="resources/js/jquery-3.6.4.js"></script>
<div id="contentDiv">
	<table>
		<tr>
			<th>공연이미지</th>
			<th>공연이름</th>
			<th>공연날짜</th>
			<th>공연장</th>
		</tr>

		<!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
		<c:forEach items="${list2}" var="book">
			<tr>
				<td>${book.poster}</td>
				<td>${book.play_name}</td>
				<td>${book.play_start} ~ ${book.play_end}</td>
				<td>${book.stage_name}</td>
			</tr>
		</c:forEach>
	</table>
</div>
