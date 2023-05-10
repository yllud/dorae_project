<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트위터 검색 결과</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#searchBtn').click(
			function() {
				var query = $('#query').val();
				if (query == '') {
					alert('검색어를 입력하세요.');
				} else {
				// Controller 호출하는 ajax 코드
					$.ajax({
						url : '../twitterSearch',
						type : 'GET',
						dataType : 'json',
						data : {
							keyword : query
						},
						success: function(result) {
						    var html = '';
						    for (var i = 0; i < result.length; i++) {
						        var tweet = result[i];
						        html += '<div style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">';
						        html += '<h3>' + tweet.user + ' (@' + tweet.screenName + ')</h3>';
						        html += '<p>' + tweet.text + '</p>';
						        html += '</div>';
						    }
							    $('#result').html(html);
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.error('AJAX error: ' + textStatus, errorThrown);
						}
					});
			}
		});
	});
</script>
</head>
<body>
	<h1>트위터 검색 결과</h1>
	<input type="text" id="query" placeholder="검색어를 입력하세요.">
	<button id="searchBtn">검색</button>
	<hr color="red">


	<hr color="red">
	<div id="result"></div>
</body>
</html>