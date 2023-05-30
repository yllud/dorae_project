<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	function submitForm(event, element) {
		event.preventDefault();
		element.closest("form").submit();
	}
</script>
</head>
<body>

	<table class="table table-striped table-hover aling-middle">
		<thead>
			<tr>
				<th class="rownum" scope="col">#</th>
				<th scope="col">공연명</th>
				<th scope="col">공연장</th>
				<th scope="col">기간</th>
				<th scope="col">장르</th>
				<th scope="col">삭제 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list2}" var="vo">
				<tr>
					<td class="rownum">${vo.rownum}</td>
					<td><form action="businessDeleteDetail" method="post"
							target="_blank">
							<input type="hidden" name="play_id" value="${vo.play_id}">
							<a href="#" onclick="submitForm(event, this);">${vo.play_name}</a>
						</form></td>
					<td>${vo.stage_name}</td>
					<td>${vo.play_start}~${vo.play_end}</td>
					<td>${vo.genre_name}</td>
					<td>${vo.delete_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>



</body>
</html>