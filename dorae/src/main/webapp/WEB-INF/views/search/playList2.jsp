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
	int rank=1;
%>
<div style="position: absolute; right: 800px; top: 250px;">
<table>
	<tr>
		<td class="left">순위</td>
		<td class="right">박스 오피스 ${cri.genre} 순위</td>
	</tr>
	<c:forEach items="${list2}" var="one">
		<tr>
			<td class="left"><%=rank%></td>
			<%	
				rank+=1;
			%>
			<td class="right"><a href="playDetail?play_id=${one.play_id}">${one.play_name}</a></td>
		</tr>
	</c:forEach>
</table>
</div>

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
