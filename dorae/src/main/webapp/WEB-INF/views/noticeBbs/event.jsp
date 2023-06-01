<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
<style>
  .detail:hover {
    cursor: pointer;
    background-color: #f2f2f2; /* 마우스 호버 시 배경색 변경 */
  }
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		// 상세페이지 클릭함수
		$('.detail').click(function() {
		var id = $(this).data('id');
		$.ajax({
			url: "detail",
			data: {
				notice_id: id
			},
			success: function(result) { // 수정된 부분
				$('#noticeBbs').html(result);
			},
			error: function(xhr, status, error) {
				alert('에러 발생');
			}
		});
	});
		
		// 페이징 버튼 클릭함수
		$('.pages').click(function() {
			var tag = '<%=request.getParameter("tag")%>';
			$.ajax({
				url : "event",
				data : {
					tag : tag,
					page : $(this).text()
				},
				success : function(result) {
					$('#event').html(result);
				},
				error : function() {
					alert('에러 발생');
				}
			});
		});
		
// 페이지 버튼 페이징 처리
		
		// 버튼 페이징 변수 선언
		var pages = <%= request.getAttribute("pages") %>;
        var buttonsPerPage = 10;
        var currentPage = 1;
        var currentButtonPage = <%= request.getAttribute("currentButtonPage") %>;

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
<table>
<c:forEach var="list" items="${list}">
<tr class="detail" data-id="${list.notice_id}">
<td>${list.tag}</td>
<td>${list.title}</td>
<td>${list.created_at}</td>
</tr>
</c:forEach>
</table>
<!--페이지버튼 -->
	<table>
	<tr>
	<td><button id="previous">이전</button></td>
	<td><div id="button-container">
	<% for (int p = 1; p <= buttonsPerPage; p++) { %>
        <button class="pages" style="display: none;"></button>
    <% } %>
	</div></td>
	<td><button id="next">다음</button></td>
	</tr>
	</table>
</body>
</html>