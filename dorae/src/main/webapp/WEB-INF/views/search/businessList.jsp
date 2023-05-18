<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('.pages').click(function() {
			// 			alert($(this).text())
			$('#result2').empty()
			$.ajax({
				url : "businessList2",
				data : {
					page : $(this).text(),
					email : $('#email_id').text(),
				},
				success : function(x) {
					$('#result2').html(x)
				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//page 버튼
	})
</script>
<style type="text/css">
td {
	/* 	width: 300px; */
	background: lime;
}
</style>
</head>
<body>
	<mark id="email_id">${cri.email}</mark>
	<!-- 		<h3>검색 결과</h3> -->
	<div id="result2">
		<table>
			<tr>
				<td>번호</td>
				<td>공연 제목</td>
			</tr>
			<c:forEach items="${list}" var="vo">
				<tr>
					<td>${vo.rownum}</td>
					<td><a href="businessDetail?play_id=${vo.play_id}">${vo.play_name}</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="footer">
		<%
			int page_cnt = (int) request.getAttribute("page_cnt");
			for (int p = 1; p <= page_cnt; p++) {
				if (p > 10) {
					break;
				}
		%>
		<button class="pages"><%=p%></button>
		<%
			}
		%>
	</div>

</body>
</html>