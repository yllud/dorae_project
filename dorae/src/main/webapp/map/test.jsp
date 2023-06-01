<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/dorae/resources/js/jquery-3.6.4.js"></script>
<script>
$(function() {
	//var email2 = "yg9316@naver.com"; //테스트용 이메일 나중에 세션으로 교체예정
	<% if (session.getAttribute("email") != null) { %>
	var email2 = '<%=session.getAttribute("email")%>';
	<% } %>
	$('#book').click(function(){
	 $.ajax({
	    	url: "/dorae/book/bookList",
	        type: "GET",
	        data: { email: email2 }, // 이메일 값을 넘겨줌
	        success: function(data) {	        	
	        	alert("북마크 클릭됨!!");
	        	console.log(data);
	          $('#bookInfo').html(data);
	        },
	        error: function() {
	          alert("데이터를 불러오는 중에 오류가 발생했습니다.");
	        }
	  	});//ajax
	});
	$('#play').click(function(){
		$.ajax({
		    url: "/dorae/map/select_recommendPlay",
		    type: "GET",
		    data: { email: email2 },
		    success: function(response) {
		        // 서버에서 성공적으로 응답을 받았을 때 실행되는 함수입니다.
		        $('#referenceInfo').html(response); // 응답 데이터를 HTML로 설정합니다.
		        alert("성공!");
		    },
		    error: function() {
		        alert("데이터를 불러오는 중에 오류가 발생했습니다.");
		    }
		});
	});
});//ready
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<button id="book">북마크</button>
<button id="play">추천공연</button>
<hr>
<div id="bookInfo"></div>
<div id="referenceInfo"></div>
</body>
</html>