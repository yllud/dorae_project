<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script>
$(function() {
	var email = "yg9316@naver.com";
	$('#book').click(function(){
	 $.ajax({
	    	url: "book/select_my",
	        type: "GET",
	        data: { email: email }, // 이메일 값을 넘겨줌
	        success: function(data) {
	          $('#bookInfo').html(data);
	        },
	        error: function() {
	          alert("데이터를 불러오는 중에 오류가 발생했습니다.");
	        }
	  	});//ajax
	});
});//ready
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<button id="book">북마크</button>
<hr>
<div id="bookInfo"></div>
</body>
</html>