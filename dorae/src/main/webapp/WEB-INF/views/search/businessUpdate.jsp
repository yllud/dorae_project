<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* body { */
/* 	background: yellow; */
/* } */
td {
	width: 100px;
}
</style>

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
			var form = $('#img')[0].files[0];
			var formData = new FormData();

			formData.append('file', form);
			formData.append('email', $('#email_id').text());
			formData.append('play_name', $('#play_name').val());
			formData.append('play_id', $('#play_id').val());
			formData.append('genre_name', $('#genre_name').val());
			formData.append('stage_name', $('#stage_name').val());
			formData.append('stage_id', $('#stage_id').val());
			formData.append('play_time', $('#play_time').val());
			formData.append('play_start', $('#play_start').val());
			formData.append('play_end', $('#play_end').val());
			formData.append('runtime', $('#runtime').val());
			formData.append('play_age', $('#play_age').val());
			formData.append('casting', $('#casting').val());
			formData.append('crew', $('#crew').val());
			formData.append('enterprise', $('#enterprise').val());
			formData.append('price', $('#price').val());
			formData.append('poster', $('#poster').val());
			formData.append('content', $('#content').val());
			formData.append('openrun', $('#openrun').val());

			$.ajax({
				type : "post",
				url : "businessUpdate2",
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				cache : false,
				data : formData,
				success : function(x) {
					alert('공연 수정 성공')
					window.close()
				},//success
				error : function() {
					alert('필수 항목을 입력해주세요')
				}//error
			})//ajax
		})//b0
		
		

// 		$('#b1').click(function() {
// 			//기존의 것 삭제됨.


// 			$.ajax({
// 				type : "post",
// 				url : "businessDelete",
// 				data : {
// 					play_id:$('#play_id').val()
// 				},
// 				success : function(x) {
// 					alert('공연 삭제 성공')
// 					window.close()
// 				},//success
// 				error : function() {
// 					alert('필수 항목을 입력해주세요')
// 				}//error
// 			})//ajax
// 		})//b1
	})
// 	})

	function openPopup() {
		window.open("businessInsertStage", "_blank", "width=600,height=600");
	}
</script>
</head>
<body>
	<h3>공연 수정</h3>
	<!-- el 속성만 받아올 수 있는 표현식 -->
	<%-- 	<img src="${vo.poster}" width="300" height="300"> --%>
	<hr color="red">
	<input id="play_id" type="hidden" value="${vo.play_id}">

	<br> 제목 :
	<input id="play_name" value="${vo.play_name}">
	<br> 장르 :
	<input id="genre_name" value="${vo.genre_name}">
	<br> 공연장 :
	<input id="stage_name" value="${vo.stage_name}" readonly>
	<br>
	<button type="button" onclick="openPopup()">공연장 변경</button>
	<input id="stage_id" type="hidden" value="${vo.stage_id}">
	<!-- 달력 -->
	<br> 공연 기간:
	<input id="play_start" class="date" value="${vo.play_start}">
	<input id="play_end" class="date" value="${vo.play_end}">
	<br> 요일별 공연 시간 :
	<input id="play_time" value="${vo.play_time}">
	<br> 런타임:
	<input id="runtime" value="${vo.runtime}">
	<br> 관람연령 :
	<input id="play_age" value="${vo.play_age}">
	<br> 출연진 :
	<input id="casting" value="${vo.casting}">
	<br> 제작진 :
	<input id="crew" value="${vo.crew}">
	<br> 기업 :
	<input id="enterprise" value="${vo.enterprise}">
	<br> 가격 :
	<input id="price" value="${vo.price}">
	<br> 이미지 변경
	<input id="img" type="file" name="file">
	<input id="poster" type="hidden" value="${vo.poster}">
	<br>
	<br> 내용 :
	<br>
	<textarea id="content" cols="40" rows="8">${vo.content}</textarea>
	<br> 오픈런 :
	<input id="openrun" value="${vo.openrun}">
	<br>
	<button id="b0">수정</button>
<!-- 	<button id="b1">삭제</button> -->


</body>
</html>