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
		$('.footer').on('click', '.pages', function() {
			// 			alert($(this).text())
			$('#result2').empty()
			$.ajax({
				type : 'post',
				url : "businessDeleteList2",
				data : {
					page : $(this).text(),
					email : $('#email_id').val()
				},
				success : function(x) {
					$('#result2').html(x)
				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//page 버튼

		$('.footer').on('click', '.next', function() {
			var page_cnt =
<%=request.getAttribute("page_cnt")%>
	;

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

	function submitForm(event, element) {
		event.preventDefault();
		element.closest("form").submit();
	}
</script>

</head>
<body>
	<div class="new-page0">
		<input id="email_id" type="hidden"
			value="<%=session.getAttribute("email")%>">



		<div
			class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			<h1 class="h2">공연 삭제 목록</h1>
		</div>


		<div id="result2" class="table-responsive">
			<table class="table table-striped table-hover aling-middle">
				<thead>
					<tr>
						<th class="rownum" scope="col">#</th>
						<th scope="col">공연명</th>
						<th scope="col">공연장</th>
						<th scope="col">기간</th>
						<th scope="col">장르</th>
						<th scope="col">삭제 날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="vo">
						<tr>
							<td class="rownum">${vo.rownum}</td>
							<td><form action="businessDeleteDetail" method="post"
									target="_blank">
									<input type="hidden" name="play_id" value="${vo.play_id}">
									<a href="#" onclick="submitForm(event, this);">${vo.play_name}</a>
								</form></td>
							<td>${vo.stage_name}</td>
							<td>${vo.play_start}~ ${vo.play_end}</td>
							<td>${vo.genre_name}</td>
							<td>${vo.delete_date}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
		<div class="footer">
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

	</div>
</body>
</html>