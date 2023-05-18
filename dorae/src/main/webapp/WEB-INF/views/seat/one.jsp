<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/themes/material_blue.min.css">

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/minMaxTimePlugin.min.js"></script>

<script type="text/javascript">

$(function() {
	
	$("#selector").flatpickr({
	    dateFormat: 'Y-m-d(D)',         // 선택한 날짜 표시되는 형식 = 년-월-일(요일) 
	    altInput: true,					// 새로운 입력형식 여부
	    altFormat: 'Y-m-d(D)',              
	    enable: [{ from: "${vo.play_start}", to: "${vo.play_end}"}],  // 특정날짜만 가능
	    minDate: "today",         		 // 최소 선택 날짜(이전날짜 선택 불가능)
	    maxDate: new Date().fp_incr(30), // 최대 선택 가능 날짜    
	    inline: true, 					 // 항상 열려있도록
	    locale: 'ko',                	 // 한국어
	    disableMobile: true,          	 // 모바일 지원   
	    onChange: function(selectedDates, dateStr, instance){ // 날짜 클릭시 이벤트
	    	const selectedDate = new Date(dateStr); //클릭한 날짜 
	    	var day = selectedDate.getDay(); // 일(0)부터 토(6)까지의 숫자를 반환
	    	var t0 = ['14시00분', '19시00분']; //일요일
	    	var t1 = ['해당 날짜는 공연이 없습니다']; //월요일
	    	var t2 = ['19시30분']; //화요일
	    	var t3 = ['14시00분', '19시00분']; //수요일
	    	var t4 = ['19시30분']; //목요일
	    	var t5 = ['19시30분']; //금요일
	    	var t6 = ['14시00분', '19시00분']; //토요일
	    	 $('.time').empty() //날짜 바뀔 때 마다 시간 선택 옵션 리셋
	    	if(day == '0'){
	    		for (var i = 0; i < t0.length; i++) {
	    			$('.time').append('<option value=' + t0[i] + '>' + t0[i] +'</option>');
	    			$("#b").attr("disabled", false); // 시간 선택했을 때 다음버튼 활성화
				}
	    	}else if(day == '1'){
	    		for (var i = 0; i < t1.length; i++) {
	    			$('.time').append('<option disabled=disabled value=' + t1[i] + '>' + t1[i] +'</option>'); // 공연없는 날은 시간선택 비활성화
	    			$("#b").attr("disabled", true); // 공연 없기 때문에 다음버튼 비활성화
				}
	    	}else if(day == '2'){
	    		for (var i = 0; i < t2.length; i++) {
	    			$('.time').append('<option value=' + t2[i] + '>' + t2[i] +'</option>');
	    			$("#b").attr("disabled", false);
				}
	    	}else if(day == '3'){
	    		for (var i = 0; i < t3.length; i++) {
	    			$('.time').append('<option value=' + t3[i] + '>' + t3[i] +'</option>');
	    			$("#b").attr("disabled", false);
				}
	    	}else if(day == '4'){
	    		for (var i = 0; i < t4.length; i++) {
	    			$('.time').append('<option value=' + t4[i] + '>' + t4[i] +'</option>');
	    			$("#b").attr("disabled", false);
				}
	    	}else if(day == '5'){
	    		for (var i = 0; i < t5.length; i++) {
	    			$('.time').append('<option value=' + t5[i] + '>' + t5[i] +'</option>');
	    			$("#b").attr("disabled", false);
				}
	    	}else if(day == '6'){
	    		for (var i = 0; i < t6.length; i++) {
	    			$('.time').append('<option value=' + t6[i] + '>' + t6[i] +'</option>');
	    			$("#b").attr("disabled", false);
				}
	    	}
	    	 var value =$('.time').val(); //선택한 시간
 			 console.log(value);
		    } //onChange
	  }); //selector flatpickr
  
	$('#b').click(function() {
			$.ajax({
				url: "seats",
				data: {
					play_id: "${vo.play_id}"
				},
				success: function(x){
					$('#seats').html(x);
					day_time.innerText = $('#selector').val() + $('.time').val(); // 관람날짜, 시간나타나도록
					
				} //success
			}) //ajax
		}) //b
	
	 
}) //$
</script>
</head>
<body>
${vo.genre_name} || ${vo.play_name}
<hr>

<img src="${vo.poster}" width="400" height="500"><br>
장소 ${vo.stage_name}<br>
기간 ${vo.play_start} ~ ${vo.play_end}<br>
시간 ${vo.play_time}<br>
가격 ${vo.price}<br>
캐스트 ${vo.casting}<br>
<hr>

<!-- 달력 -->
날짜 <input id="selector"><br>
시간 <select class="time">
		<option selected disabled="disabled">관람일을 선택해주세요</option>
	</select>

<!-- 날짜, 시간 선택해야 버튼 활성화 -->
<button type="button" class="btn btn-dark" disabled="disabled" id="b" name="play_id" value="${vo.play_id}">다음단계</button> 

<!-- <button type="submit" onclick="window.open('http://localhost:8887/dorae/seat.jsp','좌석선택','width=430,height=500,location=no,status=no')">좌석선택</button> -->

<hr>
<!-- 좌석선택 -->
<div id="seats"></div>

</body>
</html>