<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/shopcss.css">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "businessList",
			data : {
				page : 1,
				email : "ahn@naver.com",
			},

			success : function(x) {
				$('#result').html(x)
			},//success
			error : function() {
				alert('실패.@@@')
			}//error
		})//ajax
	})//$
</script>
</head>
<body>
	<h3>사업자 공연 관리 화면</h3>
	<hr color="red">

	<div id="result"></div>


</body>
</html>