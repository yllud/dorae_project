<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script>
	$(function() {
		// 페이징 버튼 클릭함수
		var query = '<%=request.getParameter("query")%>';
		$('.pages').click(function() {
			$.ajax({
				url : "playSearch",
				data : {
					query: query,
					page : $(this).text()
				},
				success : function(result) {
					$('#tagList').html(result);
				},
				error : function() {
					alert('에러 발생');
				}
			});
		});
		
		
		$('.playName').click(function() {
			var playName = $(this).text();
			$('#selectedEventName', window.opener.document).val(playName);
		    window.close();
		})
		
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
	})
</script>
<%
    int pages = (int) request.getAttribute("pages");
    int buttonsPerPage = 10;
    int currentPage = 1;
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
		<tr>
			<td>공연명</td>
			<td>장르</td>
		</tr>
		<c:forEach var="tag" items="${tag}">
			<tr>
				<td class="playName"><a href="#">${tag.play_name}</a></td>
				<td>${tag.genre_name}</td>
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