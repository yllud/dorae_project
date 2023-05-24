<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				$('#reviewList').html(result);
			},
			error : function(xhr, status, error) {
				alert('에러 발생');
			}
		});

		// 태그 검색
		$('#tagSearch').click(function() {
			var tag = $('#selectedEventName').val();
			$.ajax({
				url : "tagSearch",
				data : {
					tag : tag,
					page : 1
				},
				success : function(result) {
					$('#reviewList').html(result);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			});
		})

		// 후기 작성 버튼 클릭 함수
		$('#writeReview').click(function() {
			<%if (session.getAttribute("email") != null) {%>
			location.href = 'http://localhost:8888/dorae/review/reviewInsert.jsp';
			<%} else {%>
			alert('로그인 후 이용 가능합니다');
			location.href = 'http://localhost:8888/dorae/login/login.jsp';
			<%}%>
		});

		// 임의로 세션값 설정->테스트용 -> 추후 삭제예정
		$('#test').click(function() {
			$.ajax({
				url : "setSession",
				success : function(response) {
					alert("세션 값이 설정되었습니다.");
					location.reload(); // 페이지 새로고침
				},
				error : function(xhr, status, error) {
					alert('세션 설정 중 에러가 발생했습니다.');
				}
			});
		});

		// 임의로 세션값 설정->테스트용 -> 추후 삭제예정
		$('#logout').click(function() {
			$.ajax({
				url : "clearSession",
				success : function(response) {
					alert("로그아웃되었습니다.");
					location.reload(); // 페이지 새로고침
				},
				error : function(xhr, status, error) {
					alert('로그아웃 중 에러가 발생했습니다.');
				}
			});
		});
	});
	function openPopup() {
		window.open("tag.jsp", "_blank", "width=500,height=500");
	}
</script>
</head>
<body>
	<button id="test">로그인(테스트)</button>
	<button id="logout">로그아웃(테스트)</button>
	<br>
	<button type="button" onclick="openPopup()">태그 선택</button>
	<input type="text" id="selectedEventName" readonly>
	<button id="tagSearch">검색</button>
	<hr>
	<div id="reviewList"></div>
	<br>
	<button id="writeReview">후기 작성</button>

</body>
</html>