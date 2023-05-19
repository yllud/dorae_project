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
			var tag = $('#tag').val();
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

	});
	// 후기 작성 페이지 여는 함수
	function openMyReviewPage() {
		window.location.href = "myReview.jsp";
	}
</script>
</head>
<body>
	<input type="text" id="tag">
	<button id="tagSearch">태그 검색</button>
	<button onclick="openMyReviewPage()">후기 작성</button>
	<hr>
	<div id="reviewList"></div>

</body>
</html>