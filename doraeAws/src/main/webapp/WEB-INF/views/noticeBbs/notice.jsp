<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

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
			success: function(result) { 
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
<div id="notice-result">
<table class="bbs-table">
<tr id="head">
<td class="td1">분류</td>
<td class="td2">제목</td>
<td class="td3">날짜</td>
</tr>
<c:forEach var="list" items="${list}">
<tr class="detail" data-id="${list.notice_id}">
<td class="td1">${list.tag}</td>
<td class="td2">${list.title}</td>
<td class="td3"><fmt:timeZone value="GMT"><fmt:formatDate value="${list.created_at}" pattern="yyyy-MM-dd"/></fmt:timeZone>
</td>
</tr>
</c:forEach>
</table>
</div>
</body>
</html>