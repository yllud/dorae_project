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
		// 추천 검색어로 검색해서 db 저장 기능 -> 현재는 버튼.
		// 추후에 주기적으로 api 최신화로 변경 필요
		$.ajax({
			url : "recommend", // 추천 검색어 추출
			type : "GET",
			success : function(data) {
				// 데이터 저장 기능 클릭 함수
				$('#saveData').click(function() {

					for (var i = 0; i < data.length; i++) {
						var query = data[i];
						var rank = i + 1; // 랭크 값을 설정
						$.ajax({
							url : "saveBlog", // 블로그에 데이터 저장
							type : "GET",
							data : {
								query : query,
								rank : rank
							}
						});

						$.ajax({
							url : "saveTwitter", // 트위터에 데이터 저장
							type : "GET",
							data : {
								query : query,
								rank : rank
							}
						});
					} // for

					alert('데이터 저장 성공');
				})// click
			},
			error : function() {
				alert('에러 발생');
			}
		});

		// 추천 검색어 출력 -> 네이버만 테스트중
		$.ajax({
			url : "recommend",
			type : "GET",
			success : function(data) {
				var recommendDiv = $("#recommend");
				$.each(data, function(index, value) {
					var blogBtn = $("<button>" + value + "(블로그)</button>");
					blogBtn.click(function() {// 블로그 버튼
						searchBlog(index + 1); // 랭크 값을 입력으로 전달
					});
					recommendDiv.append(blogBtn);
					recommendDiv.append(" "); // 공백 추가
				});
				recommendDiv.append("<br>"); // 공백 추가
				$.each(data, function(index, value) {
					var twitterBtn = $("<button>" + value + "(트위터)</button>");
					twitterBtn.click(function() { // 트위터 버튼
						searchTwitter(index + 1); // 랭크 값을 입력으로 전달
					});
					recommendDiv.append(twitterBtn);
					recommendDiv.append(" "); // 공백 추가
				});
			},
			error : function() {
				console.log("에러 발생");
			}
		});

		// 추천검색어로 블로그 후기 검색하는 함수
		function searchBlog(rank) {
			$.ajax({
				url : "blogList",
				data : {
					rank : rank
				// 랭크 값을 입력값으로 전달
				},
				success : function(table) {
					$('#result').html(table);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			});
		}
		// 추천검색어로 트위터 후기 검색하는 함수
		function searchTwitter(rank) {
			$.ajax({
				url : "twitterList",
				data : {
					rank : rank
				// 랭크 값을 입력값으로 전달
				},
				success : function(table) {
					$('#result').html(table);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			});
		}

	});
</script>
</head>
<body>
	<div id="sns">
	<h1>SNS 후기 검색 결과</h1>
	<button id="saveData">db에 데이터 저장</button>
	<hr color="red">
	<div id="recommend"></div>
	<hr color="red">
	<div id="result"></div>
	</div>
</body>
</html>