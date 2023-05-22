<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/themes/material_blue.min.css">

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/minMaxTimePlugin.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#play_start").flatpickr({
			dateFormat : 'Y-m-d', // 선택한 날짜 표시되는 형식 = 년-월-일(요일) 
			altInput : true, // 새로운 입력형식 여부
			altFormat : 'Y-m-d',
			// 		    enable: [{ from: "${vo.play_start}", to: "${vo.play_end}"}],  // 특정날짜만 가능
			// 		    minDate: "today",         		 // 최소 선택 날짜(이전날짜 선택 불가능)
			// 		    maxDate: new Date().fp_incr(30), // 최대 선택 가능 날짜    
			// 			inline : true, // 항상 열려있도록
			clickOpens : true,
			locale : 'ko', // 한국어
			disableMobile : true, // 모바일 지원   
			onChange : function(selectedDates, dateStr, instance) { // 날짜 클릭시 이벤트
				const selectedDate = new Date(dateStr); //클릭한 날짜 		    	
				$('.time').empty() //날짜 바뀔 때 마다 시간 선택 옵션 리셋

				var value = $('.time').val(); //선택한 시간
				console.log(value);

			} //onChange
			
			
		}); //selector flatpickr
	
		$("#play_end").flatpickr({
			dateFormat : 'Y-m-d', // 선택한 날짜 표시되는 형식 = 년-월-일(요일) 
			altInput : true, // 새로운 입력형식 여부
			altFormat : 'Y-m-d',
// 			enable: [{ from: "$('#play_start').val()", to: "today"}],  // 특정날짜만 가능
// 			minDate : "today", // 최소 선택 날짜(이전날짜 선택 불가능)
// 			minDate: new Date().valueOf($('#play_start').val()), // 최대 선택 가능 날짜    
// 			minDate: $('#play_start').val(), // 최대 선택 가능 날짜    
// 		    maxDate: new Date().fp_incr(30), // 최대 선택 가능 날짜    
			// 			inline : true, // 항상 열려있도록
			clickOpens : true,
			locale : 'ko', // 한국어
			disableMobile : true, // 모바일 지원   
			onChange : function(selectedDates, dateStr, instance) { // 날짜 클릭시 이벤트
				const selectedDate = new Date(dateStr); //클릭한 날짜 		    	
				$('.time').empty() //날짜 바뀔 때 마다 시간 선택 옵션 리셋

				var value = $('.time').val(); //선택한 날짜
				console.log(value);
			} //onChange
		}); //selector flatpickr

		$('#b0').click(function() {
			//기존의 것 삭제됨.

			$.ajax({
				type : "post",
				url : "businessInsert2",

				data : {
					email : $('#email_id').text(),
					play_name : $('#play_name').val(),
					genre_name : $('#genre_name').val(),
					stage_name : $('#stage_name').val(),
					play_time : $('#play_time').val(),
					play_start : $('#play_start').val(),
					play_end : $('#play_end').val(),
					runtime : $('#runtime').val(),
					play_age : $('#play_age').val(),
					casting : $('#casting').val(),
					crew : $('#crew').val(),
					enterprise : $('#enterprise').val(),
					price : $('#price').val(),
					poster : $('#poster').val(),
					content : $('#content').val(),
					openrun : $('#openrun').val()
				},
				success : function(x) {
					alert('공연 추가 성공')
					window.close()
				},//success
				error : function() {
					alert('공연 추가 실패')
				}//error
			})//ajax
		})//b0

	})//$
</script>
<style type="text/css">
.date {
	width: 80px;
	/*   height:100px; */
	/*   font-size:20px; */
}
</style>
</head>
<body>
	<mark id="email_id">ahn@naver.com</mark>
	<!-- 	<mark id="email_id">session.getAttribute("email")</mark> -->
	<h3>공연 추가</h3>

	<!-- el 속성만 받아올 수 있는 표현식 -->
	<br> 제목 :
	<input id="play_name" value="도래도래">
	<br> 장르 :
	<input id="genre_name" value="연극">
	<br> 장소 :
	<input id="stage_name" value="도래극장">
	<!-- 달력 -->
	<br> 시작 날짜:
	<input id="play_start" class="date">~
	<input id="play_end" class="date">
	<br> 요일별 공연 시간 :
	<input id="play_time" value="수요일 ~ 목요일(11:00), 금요일(11:00,14:00)">
	<br> 런타임:
	<input id="runtime" value="1시간 30분">
	<br> 관람연령 :
	<input id="play_age" value="만 13세 이상">
	<br> 출연진 :
	<input id="casting" value="...">
	<br> 제작진 :
	<input id="crew" value="도래맨">
	<br> 기업 :
	<input id="enterprise" value="도래도래">
	<br> 가격 :
	<input id="price" value="전석 10,000원">
	<br> 포스터 이미지 :
	<input id="poster">
	<br> 내용 :
	<br>
	<textarea id="content" cols="40" rows="8">내요옹</textarea>
	<br> 오픈런 :
	<input id="openrun" value="Y">
	<br>
	<br>
	<button id="b0">공연 추가</button>

</body>
</html>