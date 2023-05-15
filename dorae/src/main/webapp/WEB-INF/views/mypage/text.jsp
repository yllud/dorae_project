<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		//시작하자마자 보여줄 ajax
		$.ajax({
			url : "login/testPage.jsp",
			success : function(x) {
				$('#result').append(x)
			}//success
		})//ajax

		$('#b1').click(function() {
			$('#result').empty() //기존것 삭제됨
			$.ajax({
				url : "buy.jsp",
				success : function(x) {
					$('#result').append(x)
				}//success
			})//ajax
		})//b1
	})//$
</script>
</head>
<body>
	<h2>마이스테이지박스</h2>
	${nickname} 님
	
	<a href="http://localhost:8888/dorae/login/login.jsp">
		<button>로그인</button>
	</a>
	<a href="http://localhost:8888/dorae/login/login.jsp">
		<button>회원가입</button>
	</a>
	<hr color="orange">
	
	메뉴1 메뉴2 메뉴3 메뉴4 메뉴5
	<br>
	<hr color="orange">
	<img src="../resources/img/풍경.jpg" width=180 height=180>
	<br>
	<br>
	<table border="1" width="180" heigth="30">
		<tr align="center">
			<td>닉네임</td>
			<td>id</td>
		</tr>
		<tr align="center">
			<td>가입일</td>
			<td>2000</td>
		</tr>
		<tr align="center">
			<td>관람수</td>
			<td>1</td>
		</tr>
	</table>
	<br>
	<button id="b1">예매내역</button>
	<br>
	<button id="b2">작성한 후기</button>
	<br>
	<button id="b3">문의내역</button>
	<Br>
	<button id="b4">티켓북</button>
	
	

</body>
</html>