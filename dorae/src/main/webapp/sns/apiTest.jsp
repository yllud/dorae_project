<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>api 검색 테스트</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#searchBlog").click(function() {
			$("#result").empty();
			var query = $("#query1").val();
			if (query === "") {
				alert("검색어를 입력하세요.");
				return;
			}
			$.ajax({
				url: "blogSearch",
				data: { query: query },
				success: function(result) {
					var html = "";
					for (var i = 0; i < result.length; i++) {
						var item = result[i];
						html += '<div style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">';
						html += '<h3>' + item.title + '</h3>';
						html += '<p>' + item.description + '</p>';
						html += '<a href="' + item.link + '">' + item.link + '</a>';
						html += '</div>';
					}
					$("#result").html(html);
				}
			});
		});

		$("#searchTwitter").click(function() {
			$("#result").empty();
			var query = $("#query2").val();
			if (query === "") {
				alert("검색어를 입력하세요.");
				return;
			}
			$.ajax({
				url: "twitterSearch", // Replace with your actual URL for Twitter search
				data: { query: query },
				success: function(result) {
					var html = "";
					for (var i = 0; i < result.length; i++) {
						var tweet = result[i];
						html += '<div style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">';
						html += '<h3>' + tweet.user + ' (@' + tweet.screenName + ')</h3>';
						html += '<p>' + tweet.text + '</p>';
						if (tweet.mediaUrls && tweet.mediaUrls.length > 0) {
							html += '<div>';
							for (var j = 0; j < tweet.mediaUrls.length; j++) {
								html += '<img src="' + tweet.mediaUrls[j] + '" style="max-width: 30%;">';
							}
							html += '</div>';
						}
						html += '</div>';
					}
					$("#result").html(html);
				}
			});
		});
	});
</script>
</head>
<body>
	<h1>블로그 검색 결과</h1>
	<input type="text" id="query1" placeholder="검색어를 입력하세요.">
	<button id="searchBlog">검색</button>
	<hr color="red">
	<h1>트위터 검색 결과</h1>
	<input type="text" id="query2" placeholder="검색어를 입력하세요.">
	<button id="searchTwitter">검색</button>


	<hr color="red">
	<div id="result"></div>
</body>
</html>
