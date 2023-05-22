<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/themes/material_blue.min.css">

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/minMaxTimePlugin.min.js"></script>
<style type="text/css">
body { 
  background-color: #ffffff;
  color: #000000;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-evenly;
  height: 100vh;
  font-family: 'Lato', sans-serif;
  margin: 0;
}  
select {
    font-size: 15px; /* 드롭다운 목록의 글꼴 크기 조정 */
    padding: 10px; /* 드롭다운 목록의 내부 여백 조정 */
  }
</style>
<script type="text/javascript">
$(function() {
	$("#selector").flatpickr({
	    dateFormat: 'Y-m-d(l)',         // 선택한 날짜 표시되는 형식 = 년-월-일(요일) 
	    //altInput: true,					// 새로운 입력형식 여부
	    //altFormat: 'Y-m-d(D)',              
	    enable: [{ from: "${vo.play_start}", to: "${vo.play_end}"}],  // 특정날짜만 가능
	    minDate: "today",         		 // 최소 선택 날짜(이전날짜 선택 불가능)
	    maxDate: new Date().fp_incr(30), // 최대 선택 가능 날짜    
	    inline: true, 					 // 항상 열려있도록
	    locale: 'ko',                	 // 한국어
	    disableMobile: true,          	 // 모바일 지원   
	    onChange: function(selectedDates, dateStr, instance){ // 날짜 클릭시 이벤트
	    	const input = "${vo.play_time}";
	    	const input2 = input.split(", ");
	    	const resultList = [];

	    	for (let i = 0; i < input2.length; i++) {
	    	  if (input2[i].includes("~")) {
	    	    const a = input2[i].substring(0, 3); // ~ 앞에 요일
	    	    const b = input2[i].substring(6, 9); // ~ 뒤에 요일
	    	    const time = input2[i].substring(9); // 시간

	    	    const map = new Map();
	    	    map.set(1, "월요일");
	    	    map.set(2, "화요일");
	    	    map.set(3, "수요일");
	    	    map.set(4, "목요일");
	    	    map.set(5, "금요일");
	    	    map.set(6, "토요일");
	    	    map.set(7, "일요일");

	    	    const t = { start: 0, end: 0 };
	    	    map.forEach((value, key) => {
	    	      if (value === a) {
	    	        t.start = key; // ~ 앞에 요일
	    	      }
	    	      if (value === b) {
	    	        t.end = key; // ~ 뒤에 요일
	    	      }
	    	    });

	    	    for (let j = t.start; j < t.end + 1; j++) {
	    	      resultList.push(map.get(j) + time);
	    	    }
	    	  } else {
	    	    resultList.push(input2[i]); // ~ 포함하지 않는 요일
	    	  }
	    	}
	    	 let scheduleMap = new Map();

	    	for (let entry of resultList) {
	    	  let parts = entry.split("(");
	    	  let day = parts[0];
	    	  let times = parts[1].replace(")", "").split(",");
	    	  scheduleMap.set(day, times);
	    	}
	    	for (let entry of scheduleMap.entries()) {
	    	  let day = entry[0];
	    	  let times = entry[1];
	    	}
	    	const selectedTimes = scheduleMap.get(dateStr.substring(11,14)); //클릭한 날에서 요일만 추출
	    	
	    	$('.time').empty() //날짜 바뀔 때 마다 시간 선택 옵션 리셋
	    	if (selectedTimes == undefined){ //공연 없는 날
				$('.time').append('<option selected disabled=disabled>' + "공연이 없습니다" +'</option>'); // 공연없는 날은 시간선택 비활성화
				$("#b").attr("disabled", true); // 공연 없기 때문에 다음버튼 비활성화
			}
	    	for (var i = 0; i < selectedTimes.length; i++) { //공연 있는 날
	    		if (selectedTimes) {
	    			$('.time').append('<option value=' + selectedTimes[i] + '>' + selectedTimes[i] +'</option>');
		    		$("#b").attr("disabled", false); // 시간 선택했을 때 다음버튼 활성화
				} //if
			} //for
	    	 var value =$('.time').val(); //선택한 시간
		    } //onChange
	  }); //selector flatpickr
	  
	$('#b').click(function() {
			$.ajax({
				url: "seats",
				data: {
					play_id: '${vo.play_id}'
				},
				success: function(x) {
					window.open('http://localhost:8887/dorae/seat/seats?play_id=${vo.play_id}', '좌석선택', 'width=1200, height=900, location=no, status=no, scrollbars=yes');
					localStorage.setItem("d_day", $('#selector').val()); 
					localStorage.setItem("d_time", $('.time').val()); //부모 창에서 로컬 스토리지에 정보 저장
					
				} //success
			}) //ajax
	}) //b
}) //$
</script>
</head>
<body>

<img src="${vo.poster}" width="300" height="400"><br>	
<fieldset>
<legend><${vo.genre_name}> ${vo.play_name}</legend><br>
장소 <span id="stage_name">${vo.stage_name}</span><br>
기간<span id="play_start"> ${vo.play_start} ~ ${vo.play_end}</span><br>
<hr>
시간 <span id="play_time">${vo.play_time}</span><br>
관람연령 <span id="play_age">${vo.play_age}</span><br>
<hr>
가격 <span id="price">${vo.price}</span><br>
캐스트 <span id="casting">${vo.casting}</span><br>
</fieldset>

<!-- 달력 -->
<div class="test">
날짜선택 <div id="selector"></div><br>
시간선택 <select class="time" style="width:200px;height:50px;">
		<option selected disabled="disabled">관람일을 선택해주세요</option>
	</select>

<!-- 날짜, 시간 선택해야 버튼 활성화 -->
<button class="btn btn-dark" disabled="disabled" id="b" name="play_id" value="${vo.play_id}">좌석선택</button>

</div>
</body>
</html>