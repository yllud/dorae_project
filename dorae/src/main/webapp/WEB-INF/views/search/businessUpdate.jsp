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
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/dorae/resources/css/businessSidebars.css">
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

		$('#btnUpdate').click(
				function() {
					//기존의 것 삭제됨.

					var inputFields = document
							.querySelectorAll('[data-required="true"]');
					var isEmpty = false;

					for (var i = 0; i < inputFields.length; i++) {
						if (inputFields[i].value === '') {
							isEmpty = true;
							break;
						}
					}

					if (isEmpty) {
						alert('필수 입력 항목을 입력해주세요.');
						event.preventDefault(); // 버튼 실행 취소
						return; // 함수 종료
					}

					var form = $('#img')[0].files[0];
					var formData = new FormData();

					formData.append('file', form);
					formData.append('email', $('#email_id').text());
					formData.append('play_name', $('#play_name').val());
					formData.append('play_id', $('#play_id').val());
					formData.append('genre_name', $('#genre_name').val());
					formData.append('stage_name', $('#stage_name').text());
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

	})

	function openPopup() {
		window.open("businessInsertStage", "_blank", "width=650,height=650");
	}
</script>
</head>
<body>
	<div class="new-page">
		<div
			class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			<h1 class="h2">공연 수정</h1>
		</div>
		<input id="play_id" type="hidden" value="${vo.play_id}"> <br>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*제목</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="play_name"
					value="${vo.play_name}" data-required="true">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*장르</label>
			<div class="col-sm-10">
				<select id="genre_name" class="form-control" name="type"
					data-required="true">
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
			</div>
		</div>

		<input id="stage_id" type="hidden" value="${vo.stage_id}"
			data-required="true">
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*공연장</label>
			<div class="col-sm-10">
				<mark class="col-sm-2 col-form-label" id="stage_name">${vo.stage_name}</mark>
				<button type="button" class="btn btn-primary mb-2"
					onclick="openPopup()">공연장 변경</button>
			</div>
		</div>

		<!-- 달력 -->
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*공연
				시작</label>
			<div class="col-sm-10">
				<input type="text" class="date" id="play_start"
					value="${vo.play_start}" data-required="true">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*공연
				종료</label>
			<div class="col-sm-10">
				<input type="text" class="date" id="play_end" value="${vo.play_end}"
					data-required="true">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*공연
				시간</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="play_time"
					value="${vo.play_time}" data-required="true">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*가격</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="price"
					value="${vo.price}" data-required="true">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">*오픈런</label>
			<div class="col-sm-10">
				<select id="openrun" class="form-control" name="type">
					<option disabled selected hidden value="">오픈런을 선택하세요</option>
					<option value="Y">Y</option>
					<option value="N">N</option>
				</select>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">런타임</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="runtime"
					value="${vo.runtime}">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">관람연령</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="play_age"
					value="${vo.play_age}">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">출연진</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="casting"
					value="${vo.casting}">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">제작진</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="crew" value="${vo.crew}">
			</div>
		</div>
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">기업</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="enterprise"
					value="${vo.enterprise}">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">이미지
				변경</label>
			<div class="col-sm-10">
				<input id="img" type="file" name="file"> <input id="poster"
					type="hidden" value="${vo.poster}">
			</div>
		</div>


		<div class="mb-3 row">
			<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="content" rows="5">${vo.content}</textarea>
			</div>
		</div>





		<button id="btnUpdate" class="btn btn-danger mb-3" id="b0">수정</button>



	</div>

	<script>
		var selectElement1 = document.getElementById('genre_name');
		var selectElement2 = document.getElementById('openrun');

		var selectedValue1 = '${vo.genre_name}';
		var selectedValue2 = '${vo.openrun}';

		selectElement1.value = selectedValue1;
		selectElement2.value = selectedValue2;
	</script>
</body>
</html>