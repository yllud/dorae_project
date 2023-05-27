<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('.footer').on('click', '.pages', function() {
			$.ajax({
				url : "playList2",
				data : {
					page : $(this).text(),
					title : $('#title_id').text(),
					genre : $('#genre_id').text(),
					state : $('#state_id').text()
				},
				success : function(x) {
					var $x = $(x); // x를 jQuery 객체로 변환

					// 각 div 처리 예시
					var div1 = $x.filter('.product-list2'); // 클래스가 'class1'인 div 선택

					$('#result2').empty()
					$('#result2').append(div1)

				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//page 버튼

		$('.footer').on('click', '.next', function() {
			var page_cnt = document.getElementById("a").value;
<%-- 			<%=request.getAttribute("page_cnt")%>; --%>
			

			var lastPage = parseInt($('.pages:last').text()); // 마지막 버튼의 값을 가져옴
			var end = lastPage + 10;
			end = Math.min(end, page_cnt);

			$('.pages').slice(-10).remove(); // 마지막 10개 버튼 삭제
			$('.back').remove(); // 이전 버튼 삭제
			$('.next').remove(); // 다음 버튼 삭제

			var buttonB = $('<button>').addClass('back').text("이전");
			$('.footer').append(buttonB);

			for (var p = lastPage + 1; p <= end; p++) {
				var button = $('<button>').addClass('pages').text(p);
				$('.footer').append(button);
			}

			if (end < page_cnt) {
				var buttonN = $('<button>').addClass('next').text("다음");
				$('.footer').append(buttonN);
			}
			console.log("page_cnt: " + page_cnt);
		});

		$('.footer').on('click', '.back', function() {
			var firstPage = parseInt($('.pages:first').text()); // 처음 버튼의 값을 가져옴
			var start = firstPage - 10;

			$('.pages').slice(-10).remove(); // 마지막 10개 버튼 삭제
			$('.back').remove(); // 이전 버튼 삭제
			$('.next').remove(); // 다음 버튼 삭제

			if (start != 1) {
				var buttonB = $('<button>').addClass('back').text("이전");
				$('.footer').append(buttonB);
			}

			for (var p = start; p < firstPage; p++) {
				var button = $('<button>').addClass('pages').text(p);
				$('.footer').append(button);
			}

			var buttonN = $('<button>').addClass('next').text("다음");
			$('.footer').append(buttonN);

		});
	})
</script>
<%
	int rank = 1;
	String g = (String) request.getAttribute("genre_name");
	if (!g.equals("전체(장르)")) {
%>
<div class="ranking"
	style="position: absolute; right: 60px; top: 200px;">
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



<div class="product-list2">
	<c:forEach items="${list}" var="bag">
		<!-- el 속성만 받아올 수 있는 표현식 -->
		<a href="playDetail?play_id=${bag.play_id}" class="product"> <img
			src="${bag.poster}" width="200" height="230">
			<div class="product-name">${bag.play_name}</div>
			<div class="product-name1">${bag.stage_name}</div>
			<div class="product-name2">
				<mark>${bag.genre_name}</mark>
				<mark>${bag.state}</mark>
			</div>
		</a>
	</c:forEach>

</div>


<div class="footer2">
	<input id="a" value="${page_cnt}" type="hidden">
	<%
		int start = 1;
		int end = start + 9;
		int page_cnt = (int) request.getAttribute("page_cnt");
		end = Math.min(end, page_cnt);
		for (int p = start; p <= end; p++) {
	%>
	<button class="pages"><%=p%></button>
	<%
		}
		if (page_cnt > 10) {
	%>
	<button class="next">다음</button>
	<%
		}
	%>
</div>
