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
		// 		$('.pages').click(function() {
		$('.footer').on('click', '.pages', function() {
			// 			var genre_id=$('#genre_id').text();
			// 			if(genre_id.equals("전체(장르)"))
			// 				genre_id="뮤지컬";
			$.ajax({
				url : "playList2",
				data : {
					page : $(this).text(),
					title : $('#title_id').text(),
					genre : $('#genre_id').text(),
					state : $('#state_id').text(),
					district : $('#district_id').text()
				// 						$(cri.title)
				},
				success : function(x) {
					var $x = $(x); // x를 jQuery 객체로 변환

					// 각 div 처리 예시
					var div1 = $x.filter('.product-list2'); // 클래스가 'class1'인 div 선택
					var div2 = $x.filter('.footer2'); // 클래스가 'class2'인 div 선택
					$('#result2').empty()
					// 					$('#result3').empty()
					$('#result2').append(div1)
					// 					$('#result3').append(div2)
				},
				error : function() {
					alert('실패.@@@')
				}
			})
		})//page 버튼

		$('#b1').click(function() {
			//기존의 것 삭제됨.
			$('#result2').empty()

			$('#genre_id').empty()
			$('#genre_id').append($('#genre').val())
			$('#state_id').empty()
			$('#state_id').append($('#state').val())
			$('#district_id').empty()
			$('#district_id').append($('#district').val())

			$.ajax({
				url : "playList2",
				data : {
					page : 1,
					title : $('#title').val(),
					genre : $('#genre').val(),
					state : $('#state').val(),
					district : $('#district').val()
				},
				success : function(x, genre) {
					var $x = $(x); // x를 jQuery 객체로 변환

					// 각 div 처리 예시
					var div1 = $x.filter('.product-list2'); // 클래스가 'product-list2'인 div 선택
					var div2 = $x.filter('.footer2'); // 클래스가 'footer2'인 div 선택
					var div3 = $x.filter('.ranking'); // 클래스가 'ranking'인 div 선택

					$('#result2').empty()
					$('#result3').empty()
					$('#result3').empty()

					$('#result2').append(div1)
					$('#result3').append(div2)
					$('#result4').html(div3)
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		})//b1

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
</script>
<style type="text/css">
td {
	/* 	width: 300px; */
	background: lime;
}
</style>
</head>
<body>

	<div class="filter">
		<div>
			<select id="genre" name="type">
				<option value="전체(장르)">전체(장르)</option>
				<option value="뮤지컬">뮤지컬</option>
				<option value="연극">연극</option>
				<option value="서커스/마술">서커스/마술</option>
				<option value="서양음악(클래식)">클래식</option>
				<option value="한국음악(국악)">국악</option>
				<option value="대중음악">대중음악</option>
				<option value="복합">복합</option>
				<option value="서양/한국무용(무용)">무용</option>
				<option value="대중무용">대중무용</option>
			</select> 
			<select id="district" name="type3">
				<option value="전체(지역)">전체(지역)</option>
				<option value="서울">서울</option>
				<option value="경기">경기도</option>
				<option value="부산">부산</option>
				<option value="인천">인천</option>
				<option value="대구">대구</option>
				<option value="광주">광주</option>
				<option value="대전">대전</option>
				<option value="울산">울산</option>
				<option value="충청">충청도</option>
				<option value="경상">경상도</option>
				<option value="전라">전라도</option>
				<option value="제주">제주도</option>
			</select>
			<select id="state" name="type2">
				<option value="공연중">공연중</option>
				<option value="공연예정">공연예정</option>
				<option value="공연완료">공연완료</option>
			</select>
			
			<button id="b1">적용</button>
		</div>
		<div>
			<mark id="title_id">${cri.title}</mark>
			<mark id="genre_id">${cri.genre}</mark>
			<mark id="district_id">${cri.district}</mark>
			<mark id="state_id">${cri.state}</mark>
			
			<hr color="red">
		</div>
		<br>
	</div>
	<div class="products">
		<!-- 		<h3>검색 결과</h3> -->
		<div class="rank" id="result4"></div>
		<div class="product-list" id="result2">
			<c:forEach items="${list}" var="bag">
				<!-- el 속성만 받아올 수 있는 표현식 -->
				<a href="playDetail?play_id=${bag.play_id}" class="product"> <img
					src="${bag.poster}" width="200" height="200">
					<div class="product-name">${bag.play_name}</div>
					<div class="product-name1">${bag.stage_name}</div>
					<div class="product-name2">
						<mark>${bag.genre_name}</mark>
						<mark>${bag.state}</mark>
					</div> <%-- 					<div>${bag.play_start}~${bag.play_end}</div> --%>
				</a>
			</c:forEach>

		</div>

		<div class="clearfix">

			<div id="result3" class="footer">
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
	</div>
</body>
</html>