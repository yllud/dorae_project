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
					title : $('#result3').text()
// 						$(cri.title)
				},
				success : function(x) {
					$('#result2').html(x)
				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//b1
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


	<%
		int page_cnt = (int) request.getAttribute("page_cnt");
		for (int p = 1; p <= page_cnt; p++) {
	%>
	<button class="pages"><%=p%></button>
	<%
		}
	%>
	<div id="result3">${cri.title}</div>
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
	</div>
</body>
</html>