<%@page import="com.multi.dorae.login.NaverVO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<style>
.button {
	margin-top: 20px;
}
</style>
<script>
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
						url: "mypage/replyList", // 표시할 페이지의 URL
						type: "GET",
						dataType: "html",
						success: function(data) {
							// Ajax 요청이 성공하면 reviewList 영역에 결과를 표시
							$("#reviewList").html(data);
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
<%
	if(session.getAttribute("email") != null){
%>
	<h2>마이스테이지박스</h2>
	${nickname} 님

		<button>로그아웃</button>
	
	<a href="http://localhost:8888/dorae/login/login.jsp">
		<button>회원가입</button>
	</a>
	<hr color="orange">

	메뉴1 메뉴2 메뉴3 메뉴4 메뉴5
	<br>
	<hr color="orange">
	<img src="../resources/img/풍경.jpg" width=180 height=180>
	<br>
<form action="uploadProfileImage.jsp" method="post" enctype="multipart/form-data">
  <input type="file" name="profileImage">
  <input type="submit" value="프로필 사진 업로드">
</form>
<br>
	<table border="1" width="150" heigth="30">
		<tr align="center">
			<td>닉네임</td>
			<td>${nickname}</td>
		</tr>
		<tr align="center">
			<td>가입일</td>
			<td><fmt:formatDate value="${joinDate}" pattern="yyyy년 MM월 dd일"/></td>
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
	<hr color="pink">

	<hr color="red">
	<!-- 예매내역을 표시할 영역 -->
	<div id="ticketInfo"></div>

<%}else{out.println("<script type='text/javascript'>alert('로그인 실패');location.href = 'http://localhost:8888/dorae/login/login.jsp'</script>");} %>
</body>
</html>