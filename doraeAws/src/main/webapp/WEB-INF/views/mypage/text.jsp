<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			function openPopup() {
				var popupWindow = window.open("replyPopup.jsp", "popupWindow",
						"width=500,height=500");
			}

			// b1 버튼을 클릭할 때 Ajax 요청을 보내고 결과를 받아옴
			$(document).on("click", "#b1", function() {
				$.ajax({
					url : "../mypage/ticketList.jsp", // 표시할 페이지의 URL
					type : "GET",
					dataType : "html",
					success : function(data) {
						// Ajax 요청이 성공하면 ticketInfo 영역에 결과를 표시
						$("#ticketInfo").html(data);
					},
					error : function() {
						// Ajax 요청이 실패하면 에러 처리
						alert("예매내역을 가져오는 중에 오류가 발생했습니다.");
					}
				});
			}); //b1
			// b2 버튼을 클릭할 때 Ajax 요청을 보내고 결과를 받아옴
			$(document).on("click", "#b2", function() {
				$.ajax({
					url: "../mypage/replyList.jsp", // 표시할 페이지의 URL
					type: "GET",
					dataType: "html",
					success: function(data) {
						// Ajax 요청이 성공하면 reviewList 영역에 결과를 표시
						$("#replyList").html(data);
					},
					error: function() {
						// Ajax 요청이 실패하면 에러 처리
						alert("작성한 후기를 가져오는 중에 오류가 발생했습니다.");
					}
				});
			}); //b2
		});
</script>
</head>
<body>
	<h2>마이스테이지박스</h2>
	${nickname} 님
	
	<a href="../login/login.jsp">
		<button>로그인</button>
	</a>
	<a href="../login/login.jsp">
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