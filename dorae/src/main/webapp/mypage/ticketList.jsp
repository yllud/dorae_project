<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<style>
        .button {
            margin-top: 20px;
        }
</style>
<script type="text/javascript">
$(function() {
	//시작하자마자 보여줄 ajax
	$.ajax({
		url : "../mypage/ticketList?page=1", //views 아래에 있는 replyList.jsp
		success : function(x) {
			$('#result').html(x) //결과값 이름을 result로 한 것
		}//success
	})//ajax
})//$
</script>
</head>
<body>
	<h2>예매내역</h2>
	${nickname} 님
<hr color="blue">
	<div id="result">
	<!-- ajax의 $('#result').html(x)에서 result(결과)가 표시될 위치 -->
    </div>
<hr color="blue">

<button onclick="openPopup()">후기작성</button>
    
    <script>
        function openPopup() {
            var popupWindow = window.open("../mypage/replyPopup.jsp", "popupWindow", "width=500,height=500");
        }
    </script>
	

</body>
</html>