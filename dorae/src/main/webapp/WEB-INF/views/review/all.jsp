<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('.pages').click(function() {
			$.ajax({
				url : "all", 
				data : {
					page : $(this).text()
				},
				success : function(result) { //결과가 담겨진 table부분코드
					$('#resultList').html(result)
				},
				error : function() {
					alert('실패.@@@')
				}
			}) //ajax
		})
	})
</script>
<style>
td {
	background: white;
	height: 30px;
}
</style>
</head>
<body>
<h3>전체 review 글 count: ${count}</h3>
<hr color="red">
<%
	int pages = (int)request.getAttribute("pages");
	for(int p = 1; p <= pages; p++){
%>
	<button style="background: lime; color: red; width: 50px;" class="pages"><%= p %></button>
<%		
	}
%>
<hr color="red">
<h1>후기 목록</h1>
	<c:choose>
		<c:when test="${not empty list}">
			<c:forEach var="review" items="${list}">
				<div id = "resultList">
					<h3>제목: ${review.title}</h3>
					<p>내용: ${review.content}</p>
					<p>태그: ${review.tag}</p>
					<c:if test="${not empty review.images}">
						<c:forEach var="image" items="${review.images}">
							<img src="../resources/upload/${image}" alt="후기 이미지" width="300"
								height="300" />
						</c:forEach>
					</c:if>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<p>후기가 없습니다.</p>
		</c:otherwise>
	</c:choose>
</body>
</html>