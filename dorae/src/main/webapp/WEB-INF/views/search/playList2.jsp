<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('.pages').click(function() {
			//alert($(this).text())
			$('#result2').empty()
			$.ajax({
				url : "playList2",
				data : {
					page : $(this).text(),
					title : $('#title_id').text(),
					genre : $('#genre_id').text(),
					state : $('#state_id').text()
				},
				success : function(x) {
					$('#result2').html(x)
				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//page 버튼

	})
</script>
<%
	int rank = 1;
	String g = (String) request.getAttribute("genre_name");
	if (!g.equals("전체(장르)")) {
%>
<div style="position: absolute; right: 60px; top: 200px;">
	<table>
		<tr>
			<td class="rank-left">순위</td>
			<td class="rank-right">박스 오피스 ${cri.genre} 순위</td>
		</tr>
		<c:forEach items="${list2}" var="one">
			<tr>
				<td class="rank-left"><%=rank%></td>
				<%
					rank += 1;
				%>
				<td class="rank-right"><a
					href="playDetail?play_id=${one.play_id}">
						<div class="rank-right2">${one.play_name}</div>
				</a></td>
			</tr>
		</c:forEach>
	</table>
</div>
<%
	}
%>



<div class="product-list">
	<c:forEach items="${list}" var="bag">
		<!-- el 속성만 받아올 수 있는 표현식 -->
		<a href="playDetail?play_id=${bag.play_id}" class="product"> <img
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
