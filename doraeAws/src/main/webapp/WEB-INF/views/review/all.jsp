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
			window.open('detail?id=' + id, '_blank', "width=500,height=550"); // 상세 페이지를 새 창에서 열기
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

		// 페이지 버튼 페이징 처리

		// 버튼 페이징 변수 선언
		var pages =
<%=request.getAttribute("pages")%>
	;
		var buttonsPerPage = 10;
		var currentPage = 1;
		var currentButtonPage =
<%=request.getAttribute("currentButtonPage")%>
	;

		function updateButtons() {
			var start = (currentButtonPage - 1) * buttonsPerPage + 1;
			var end = Math.min(start + buttonsPerPage - 1, pages);

			$('.pages').each(function(index) {
				var buttonText = start + index;
				if (buttonText <= end) {
					$(this).text(buttonText).show();
				} else {
					$(this).hide();
				}
			});

			// 이전 버튼 숨기기
			if (currentButtonPage === 1) {
				$('#previous').hide();
			} else {
				$('#previous').show();
			}

			// 다음 버튼 숨기기
			var totalPages = Math.ceil(pages / buttonsPerPage);
			if (currentButtonPage === totalPages) {
				$('#next').hide();
			} else {
				$('#next').show();
			}
		}

		// 이전버튼
		$('#previous').click(function() {
			if (currentButtonPage > 1) {
				currentButtonPage--;
				updateButtons();
			}
		});

		// 다음버튼
		$('#next').click(function() {
			var totalPages = Math.ceil(pages / buttonsPerPage);
			if (currentButtonPage < totalPages) {
				currentButtonPage++;
				updateButtons();
			}
		});

		updateButtons();
	});
</script>
<%
	int pages = (int) request.getAttribute("pages");
int buttonsPerPage = 10;
int currentPage = 1;
%>
</head>
<body>
	<div>
		<div id="top"><h1>다녀온 후기</h1><h3>전체 후기 수: ${count}</h3></div>
	<hr color="#ff9900">
		<c:choose>
			<c:when test="${not empty list}">
				<table>
				<tr>
				<c:forEach var="review" items="${list}" varStatus="status">
				<td class="review-detail" data-id="${review.id}">
				<table class="review-table">
					<tr>
						<td class="td1"><img src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/pin.png" width="35" height="40"></td>
						<td class="td2">${review.tag}</td>
					</tr>
					<tr>
						<td colspan="2" class="img-td"><c:choose>
								<c:when test="${not empty review.images}">
									<img src="../resources/upload/${review.images[0]}" alt="후기 이미지" class="review-img" />
								</c:when>
								<c:otherwise>
									<div class="no-image">후기 이미지가 없습니다.</div>
								</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<td colspan="2" class="bold-text">${review.title}</td>
					</tr>
					<tr>
						<td colspan="2" class="light-text">${review.email}</td>
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
	<!--페이지버튼 -->
	<div class="pageButton">
	<table>
		<tr>
			<td><button id="previous">이전</button></td>
			<td><div id="button-container">
					<%
						for (int p = 1; p <= buttonsPerPage; p++) {
					%>
					<button class="pages" style="display: none;"></button>
					<%
						}
					%>
				</div></td>
			<td><button id="next">다음</button></td>
		</tr>
	</table>
	</div>
</body>
</html>
