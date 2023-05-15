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

		// 추천 검색어로 검색해서 db 저장 기능
		$.ajax({
			url : "recommend", // 추천 검색어 추출
			type : "GET",
			success : function(data) {
				// 데이터 저장 기능 클릭 함수
				$('#saveData').click(function() {

					for (var i = 0; i < data.length; i++) {
						var query = data[i];
						$.ajax({
							url : "saveBlog", // 블로그에 데이터 저장
							type : "GET",
							data : {
								query : query
							}
						});

						$.ajax({
							url : "saveTwitter", // 트위터에 데이터 저장
							type : "GET",
							data : {
								query : query
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

		
		// 추천 검색어 출력
		$.ajax({
		    url: "recommend",
		    type: "GET",
		    success: function(data) {
		        var recommendDiv = $("#recommend");
		        $.each(data, function(index, value) {
		            var keyword = $("<p>" + value + "</p>");
		            var button = $("<button>" + value + "</button>");
		            button.click(function() {
		                searchByKeyword(value);
		            });
		            keyword.append(button);
		            recommendDiv.append(keyword);
		        });
		    },
		    error: function() {
		        console.log("에러 발생");
		    }
		});

		// 블로그 후기 검색 버튼 함수
		function searchByKeyword(keyword) {
			$.ajax({
				url : "blogList2",
				data : {
					query : keyword
				},
				success : function(table) {
					$('#result').html(table);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			});
		}

		// 트위터 후기 검색 버튼 함수
		$('#searchTwitter').click(function() {
			$.ajax({
				url : "twitterList",
				success : function(table) {

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
	<hr color="red">
	<div id="recommend"></div>
	<button id="saveData">db에 데이터 저장</button>
	<button id="searchBlog">블로그 후기 검색</button>
	<button id="searchTwitter">트위터 후기 검색</button>
	<hr color="red">

	<div id="result"></div>
</body>
</html>