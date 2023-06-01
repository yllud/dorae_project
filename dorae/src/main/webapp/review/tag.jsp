<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/reviewStyle.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {
		$.ajax({
			url : "tag",
			data : {
				page : 1
			},
			success : function(result) {
				$('#tagList').html(result)
			},
			error : function() {
				alert('에러 발생');
			}
		})
		
		// 장르 필터
		$('#filterBtn').click(function() {
			var genre = $('#genre').val()
			$.ajax({
				url : "genreSearch",
				data : {
					page : 1,
					genre : genre
				},
				success : function(result) {
					$('#tagList').html(result);
				},
				error : function() {
					alert('에러 발생');
				}
			})
		})
		
		// 공연명 검색
		$('#searchBtn').click(function() {
			var query = $('#query').val()
			$.ajax({
				url : "playSearch",
				data : {
					query : query,
					page : 1
				},
				success : function(result) {
					$('#tagList').html(result);
				},
				error : function() {
					alert('에러 발생');
				}
			})
		})
		
		// 전체 목록
		$('#return').click(function() {
			$.ajax({
				url : "tag",
				data : {
					page : 1
				},
				success : function(result) {
					$('#tagList').html(result)
				},
				error : function() {
					alert('에러 발생');
				}
			})
		})
	})
</script>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<div id="tagTotal">
<button id="return">전체목록</button>
	<select id="genre" name="type">
				<option value="뮤지컬">뮤지컬</option>
				<option value="연극">연극</option>
				<option value="서커스/마술">서커스/마술</option>
				<option value="서양음악(클래식)">클래식</option>
				<option value="한국음악(국악)">국악</option>
				<option value="대중음악">대중음악</option>
				<option value="복합">복합</option>
				<option value="서양/한국무용(무용)">무용</option>
				<option value="대중무용">대중무용</option>
			</select>
			<button id="filterBtn">장르로 검색</button><br>
	공연명 검색 <input type="text" id="query"><button id="searchBtn">검색</button>
	<div id="tagList">
	</div>
	</div>
</body>
</html>