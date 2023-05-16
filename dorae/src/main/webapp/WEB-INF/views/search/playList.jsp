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
				success : function(x,genre) {
					//alert(x)
					$('#result2').html(x)
				},//success
				error : function() {
					alert('검색 실패')
				}//error
			})//ajax
		})//b0
	})
</script>
<style type="text/css">
/* body { */
/* 	background: yellow; */
/* } */
td {
	width: 100px;
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



<%-- 	키워드:<div id="result3">${cri.title}</div> --%>
	<mark id="title_id">${cri.title}</mark>
	<mark id="genre_id">${cri.genre}</mark>
	<mark id="state_id">${cri.state}</mark>
	<br>

	<select id="genre" name="type">
		<option value="전체(장르)">전체(장르)</option>
		<option value="뮤지컬">뮤지컬</option>
		<option value="연극">연극</option>
		<option value="서커스/마술">서커스</option>
		<option value="서양음악(클래식)">클래식</option>
		<option value="한국음악(국악)">국악</option>
		<option value="대중음악">대중음악</option>
		<option value="복합">복합</option>
		<option value="서양/한국무용(무용)">무용</option>
		<option value="대중무용">대중무용</option>
	</select>
	<select id="state" name="type2">
		<option value="공연중">공연중</option>
		<option value="공연예정">공연예정</option>
		<option value="공연완료">공연완료</option>
	</select>
	<button id="b1">적용</button>
	<br>
	<h3>검색 결과</h3>
	<div id="result2">
		<c:forEach items="${list}" var="bag">
			<!-- el 속성만 받아올 수 있는 표현식 -->
			<img src="${bag.poster}" width="200" height="200">
			<br>
		제목 : <a href="playDetail?play_id=${bag.play_id}">${bag.play_name}</a>
			<br>
		장르: ${bag.genre_name}<br>
		출연진: ${bag.casting}<br>
		기간: ${bag.play_start} ~ ${bag.play_end}<br>
		공연 상태: ${bag.state}<br>

		</c:forEach>
	
	<br>
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
</body>
</html>