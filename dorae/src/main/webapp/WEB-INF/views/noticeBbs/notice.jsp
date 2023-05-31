<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .detail:hover {
    cursor: pointer;
    background-color: #f2f2f2; /* 마우스 호버 시 배경색 변경 */
  }
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$('.detail').click(function() {
		var id = $(this).data('id');
		$.ajax({
			url: "detail",
			data: {
				notice_id: id
			},
			success: function(result) { // 수정된 부분
				$('#noticeBbs').html(result);
			},
			error: function(xhr, status, error) {
				alert('에러 발생');
			}
		});
	});
});
		
		

</script>

</head>
<body>
<table>
<tr>
<td>분류</td>
<td>제목</td>
<td>공지날짜</td>
</tr>
<c:forEach var="list" items="${list}">
<tr class="detail" data-id="${list.notice_id}">
<td>${list.tag}</td>
<td>${list.title}</td>
<td>${list.created_at}</td>
</tr>
</c:forEach>
</table>
</body>
</html>