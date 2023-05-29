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
<!-- 		<table> -->
<%-- 			<c:forEach items="${list2}" var="vo"> --%>
<!-- 				<tr> -->
<%-- 					<td>${vo.rownum}</td> --%>
<!-- 					<td><form action="businessDetail" method="post" target="_blank"> -->
<%-- 							<input type="hidden" name="play_id" value="${vo.play_id}"> --%>
<%-- 							<a href="#" onclick="submitForm(event, this);">${vo.play_name}</a> --%>
<!-- 						</form></td> -->

<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->

		
		<table class="table table-striped table-hover aling-middle">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">제목</th>
<!-- 					<th scope="col">유형</th> -->
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list2}" var="vo">
					<tr>
						<td>${vo.rownum}</td>
						<td><form action="businessDetail" method="post"
							target="_blank">
							<input type="hidden" name="play_id" value="${vo.play_id}">
							<a href="#" onclick="submitForm(event, this);">${vo.play_name}</a>
						</form></td>
<%-- 						<td>${item.help_category_id }</td> --%>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	

</body>
</html>