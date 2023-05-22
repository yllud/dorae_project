<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 상세페이지 클릭함수
		$('.review-detail').click(function() {
			var id = $(this).data('id'); // 클릭한 요소의 data-id 속성에서 id 추출
			window.open('detail?id=' + id, '_blank'); // 상세 페이지를 새 창에서 열기
		});
		
		// 페이징 버튼 클릭함수
		$('.pages').click(function() {
			$.ajax({
				url : "all",
				data : {
					page : $(this).text()
				},
				success : function(result) {
					$('#reviewList').html(result);
				},
				error : function() {
					alert('에러 발생');
				}
			});
		});
	});
</script>
<link rel="stylesheet" type="text/css" href="../resources/css/reviewStyle.css">
</head>
<body>
	<h3>전체 review 글 count: ${count}</h3>
	<hr color="red">
	<div>
		<h1>후기 목록</h1>
		<c:choose>
			<c:when test="${not empty list}">
				<table>
					<tr>
						<c:forEach var="review" items="${list}" varStatus="status">

							<td class="review-detail" data-id="${review.id}">
								<table>
									<tr>
										<td>작성자:</td>
										<td>${review.email}</td>
									</tr>
									<tr>
										<td>제목:</td>
										<td>${review.title}</td>
									</tr>
									<tr>
										<td>내용:</td>
										<td>${review.content}</td>
									</tr>
									<tr>
										<td>태그:</td>
										<td>${review.tag}</td>
									</tr>
									<tr>
										<td colspan="2"><c:choose>
												<c:when test="${not empty review.images}">
													<img src="../resources/upload/${review.images[0]}"
														alt="후기 이미지" />
												</c:when>
												<c:otherwise>
													<div class="no-image">후기 이미지가 없습니다.</div>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</table>
							</td>
						</c:forEach>
					</tr>
				</table>
			</c:when>
			<c:otherwise>
				<p>후기가 없습니다.</p>
			</c:otherwise>
		</c:choose>
	</div>
	<hr color="red">
	<!--페이지버튼 -->
	<%
	int pages = (int) request.getAttribute("pages");
	for (int p = 1; p <= pages; p++) {
	%>
	<button class="pages"><%=p%></button>
	<%
		}
	%>
</body>
</html>
