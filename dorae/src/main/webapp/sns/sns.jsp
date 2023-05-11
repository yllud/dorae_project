<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SNS 후기 검색 결과</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 블로그 후기 검색 버튼 함수
		$('#searchBlog').click(function() {
			$.ajax({
				url : "blogList",
				success : function(table) {
					console.log(table)
					$('#result').html(table)
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			})
		})// click

		// 트위터 후기 검색 버튼 함수
		$('#searchTwitter').click(function() {
			$.ajax({
				url : "twitterList",
				success : function(table) {
					console.log(table)
					$('#result').html(table)
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			})
		})// click

	});
</script>
</head>
<body>
	<h1>SNS 후기 검색 결과</h1>
	<button id="searchBlog">블로그 후기 검색</button>
	<button id="searchTwitter">트위터 후기 검색</button>
	<hr color="red">

	<div id="result"></div>
</body>
</html>