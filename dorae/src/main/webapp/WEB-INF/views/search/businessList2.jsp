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
<!-- 	<div id="result"> -->
		<table>
			<c:forEach items="${list2}" var="vo">
				<tr>
					<td>${vo.rownum}</td>
					<td><form action="businessDetail" method="post" target="_blank">
							<input type="hidden" name="play_id" value="${vo.play_id}">
							<a href="#" target=”_blank“ onclick="submitForm(event, this);">${vo.play_name}</a>
						</form></td>

				</tr>
			</c:forEach>
		</table>
<!-- 	</div> -->
	

</body>
</html>