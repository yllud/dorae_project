<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>SNS 후기</title>
<link rel="stylesheet" href="/dorae/resources/css/sns.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("/dorae/header/header.jsp");
		
        // 추천 검색어로 검색해서 db 저장 기능 -> 현재는 버튼.
        // 테스트용으로 남겨두고 추후에 삭제
        $.ajax({
            url : "recommend", // 추천 검색어 추출
            type : "GET",
            success : function(data) {
                // 데이터 저장 기능 클릭 함수
                $('#saveData').click(function() {
                	 var modifiedData = []; // 수정된 데이터를 저장할 배열
                	 for (var i = 0; i < data.length; i++) {
                	        var query = data[i];
                	        var modifiedQuery = query.replace(/\s*\[.*?\]|\s*\([^)]*\)$/g, "").trim(); // 검색어 수정
                	        modifiedData.push(modifiedQuery);
                	        
                	        var rank = i + 1; // 랭크 값을 설정
                	        $.ajax({
                	          url: "saveBlog", // 블로그에 데이터 저장
                	          type: "GET",
                	          data: {
                	            query: modifiedQuery,
                	            rank: rank
                	          }
                	        });

                	        $.ajax({
                	          url: "saveTwitter", // 트위터에 데이터 저장
                	          type: "GET",
                	          data: {
                	            query: modifiedQuery,
                	            rank: rank
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
			url : "recommend",
			type : "GET",
			success : function(data) {
				var recommendDiv = $("#recommend");
				$.each(data, function(index, value) {
					var btn = $("<button>" + value + "</button>");
					btn.click(function() {
						var searchType = $("input[name='searchType']:checked").val();
						if (searchType === "blog") {
							searchBlog(index + 1);
						} else if (searchType === "twitter") {
							searchTwitter(index + 1);
						}
					})
					recommendDiv.append(btn);
					recommendDiv.append(" "); // 공백 추가
				});
			},
			error : function() {
				console.log("에러 발생");
			}
		});
		
		// 메뉴 첫 화면 - 블로그1번
			$.ajax({
				url : "blogList",
				data : {
					rank : 1
				// 랭크 값을 입력값으로 전달
				},
				success : function(table) {
					$('#result').html(table);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
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
<style>

</style>

</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="sns">
	    <!-- <button id="saveData">db에 데이터 저장</button> -->
	<div id="top"><h1>SNS후기</h1><hr color="#ff9900">
	
	
	<div id="recDiv">
	<div id="radioDiv">
	<input type="radio" id="blogRadio" name="searchType" value="blog" checked>
	<label for="blogRadio">블로그</label>
	<input type="radio" id="twitterRadio" name="searchType" value="twitter">
	<label for="twitterRadio">트위터</label>
	</div>
	<div id="recommend"></div>
	</div>
	<hr color="#ff9900">
	</div>
	<div id="result"></div>
	</div>
</body>
</html>