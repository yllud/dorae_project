<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('.pages').click(function() {
			// 			alert($(this).text())
			$('#result2').empty()
			$.ajax({
				url : "playList2",
				data : {
					page : $(this).text(),
					title : $('#title_id').text(),
					genre : $('#genre_id').text(),
					state : $('#state_id').text()
				// 						$(cri.title)
				},
				success : function(x) {
					$('#result2').html(x)
				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//page 버튼

		$('#b1').click(function() {
			//기존의 것 삭제됨.
			$('#result2').empty()

			$('#genre_id').empty()
			$('#genre_id').append($('#genre').val())
			$('#state_id').empty()
			$('#state_id').append($('#state').val())

			$.ajax({
				url : "playList2",
				data : {
					page : 1,
					title : $('#title').val(),
					genre : $('#genre').val(),
					state : $('#state_id').text()
				},
				success : function(x, genre) {
					//alert(x)
					$('#result2').html(x)
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		})//b1
	})
</script>
<style type="text/css">
/* body { */
/* 	background: yellow; */
/* } */
td {
	/* 	width: 300px; */
	background: lime;
}

/* .top{ */
/* 	background: black; */
/* 	color:white; */
/* } */
/* .down{ */
/* 	background: lime; */
/* } */
</style>
</head>
<body>

	<div class="filter">
			<select id="genre" name="type">
				<option value="전체(장르)">전체(장르)</option>
				<option value="뮤지컬">뮤지컬</option>
				<option value="연극">연극</option>
				<option value="서커스/마술">서커스/마술</option>
				<option value="서양음악(클래식)">클래식</option>
				<option value="한국음악(국악)">국악</option>
				<option value="대중음악">대중음악</option>
				<option value="복합">복합</option>
				<option value="서양/한국무용(무용)">무용</option>
				<option value="대중무용">대중무용</option>
			</select> <select id="state" name="type2">
				<option value="공연중">공연중</option>
				<option value="공연예정">공연예정</option>
				<option value="공연완료">공연완료</option>
			</select>
			<button id="b1">적용</button>
			<br>
			<hr color="red">
			<mark id="title_id">${cri.title}</mark>
			<mark id="genre_id">${cri.genre}</mark>
			<mark id="state_id">${cri.state}</mark>
			<br> <br>
	</div>
	<div class="products">
		<!-- 		<h3>검색 결과</h3> -->
		<div class="product-list" id="result2">
			<c:forEach items="${list}" var="bag">
				<!-- el 속성만 받아올 수 있는 표현식 -->
				<a href="playDetail?play_id=${bag.play_id}" class="product" target="_blank"> <img
					src="${bag.poster}" width="200" height="200">
					<div class="product-name">${bag.play_name}</div>
					<div>${bag.genre_name}</div>
					<div>${bag.state}</div>
					<div>${bag.play_start}~${bag.play_end}</div>
				</a>
			</c:forEach>
			<div class="clearfix">

				<div class="footer">
					<%
						int page_cnt = (int) request.getAttribute("page_cnt");
						for (int p = 1; p <= page_cnt; p++) {
							if (p > 10) {
								break;
							}
					%>
					<button class="pages"><%=p%></button>
					<%
						}
					%>
				</div>
			</div>
		</div>
</body>
</html>