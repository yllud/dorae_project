<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
$(function() {
	//시작하자마자 보여줄 ajax
	$.ajax({
		url : "../mypage/reviewList", //views 아래에 있는 replyList.jsp
		success : function(x) {
			$('#result').html(x) //결과값 이름을 result로 한 것
		}//success
	})//ajax
})//$
</script>
</head>
<body>
<h2>커뮤니티 글 내역</h2>
<div id="result">
</body>
</html>