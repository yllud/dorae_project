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
				type : 'post',
				url : "businessList2",
				data : {
					page : $(this).text(),
					email : $('#email_id').text()
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

</head>
<body>

	<mark id="email_id">${cri.email}</mark>
	<!-- 	<mark id="email_id">session.getAttribute("email")</mark> -->
	<!-- 		<h3>검색 결과</h3> -->
	<div id="result2">
	<form action="businessInsert" method="post" target="_blank">
		<button>공연 추가</button>
	</form>
		<table>
			<c:forEach items="${list}" var="vo">
				<tr>
					<td>${vo.rownum}</td>
					<td>${vo.play_name}</td>
					<!-- 					에이작스에 넣어주자 -> $("#pet-select").val() -->
					<td><form action="businessUpdate" method="post" target="_blank">
							<input type="hidden" name="play_id" value="${vo.play_id}">
							<button>수정</button>
						</form></td>
					<td><button>삭제</button></td>
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