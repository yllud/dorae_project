<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background: white;
}

td {
	width: 100px;
	text-align: center;
}

.top {
	background: pink;
	color: black;
}

.down {
	background: gray;
	color: white;
}
</style>
<script type="text/javascript" src="resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
$(function() {
	//시작하자마자 보여줄 ajax
	$.ajax({
		url : "../mypage/replyList?page=1", //views 아래에 있는 replyList.jsp
		success : function(x) {
			$('#result').html(x) //결과값 이름을 result로 한 것
		}//success
	})//ajax
})//$
</script>
</head>
<body>
<h2>후기내역</h2>
	<div id="result">
	<!-- ajax의 $('#result').html(x)에서 result(결과)가 표시될 위치 -->
    </div>
</body>
</html>