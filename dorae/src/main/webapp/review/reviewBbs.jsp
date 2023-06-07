<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다녀온 후기</title>
<link rel="stylesheet" href="../resources/css/reviewStyle.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {
		$("#header").load("../header/header.jsp");
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
			 var form = $('<form action="reviewInsert.jsp" method="post"></form>');
			    $('body').append(form);
			    form.submit();
			<%} else {%>
			alert('로그인 후 이용 가능합니다');
			location.href = '../login/login.jsp';
			<%}%>
		});

		
	});
	function openPopup() {
		window.open("tag.jsp", "_blank", "width=700,height=600");
	}
</script>

</head>
<body>
<header id="header" class="fixed-top"></header>
<div class="body">
	<div id="searchDiv">
	<button type="button" onclick="openPopup()" id="tagButton">태그 선택</button>
	<input type="text" id="selectedEventName" placeholder="태그를 선택하여 검색해보세요" readonly>
	<button id="tagSearch">적용</button>
	</div>
	<div id="reviewList"></div>
	<button id="writeReview">후기 작성</button>
</div>
</body>
</html>