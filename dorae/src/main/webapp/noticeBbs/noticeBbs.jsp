<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {
		$.ajax({
			url : "all",
			data : {
				page : 1
			},
			success : function(result) {
				$('#result').html(result);
			},
			error : function(xhr, status, error) {
				alert('에러 발생');
			}
		})
	})
</script>
</head>
<body>
	<div id="result"></div>
</body>
</html>