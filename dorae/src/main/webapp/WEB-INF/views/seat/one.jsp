<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/themes/material_orange.min.css">
<link rel="stylesheet" href="../resources/css/booking.css">

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/minMaxTimePlugin.min.js"></script>

<script type="text/javascript">
$(function() {
	$("#selector").flatpickr({
	    dateFormat: 'Y-m-d(l)',         // 선택한 날짜 표시되는 형식 = 년-월-일(요일) 
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
	    	if (selectedTimes === undefined){ //공연 없는 날
				$('.time').append('<option selected disabled=disabled>' + "공연이 없습니다" +'</option>'); // 공연없는 날은 시간선택 비활성화
				$("#b").attr("disabled", true); // 공연 없기 때문에 다음버튼 비활성화
			}else if(selectedTimes !== undefined){
	    		for (var i = 0; i < selectedTimes.length; i++) { //공연 있는 날
	    		  if (selectedTimes) {
	    			$('.time').append('<option value=' + selectedTimes[i] + '>' + selectedTimes[i] +'</option>');
		    		$("#b").attr("disabled", false); // 시간 선택했을 때 다음버튼 활성화
				   } //if
			   } //for
	    	}// else if
	    	 $('#d_day').text($('#selector').val());
	    	 $('#d_time').text($('.time').val());
		    } //onChange
	  }); //selector flatpickr
	  
	$('.time').click(function() {
		$('#d_time').text($('.time').val());
	}) //time
	  
	$('#b').click(function() {
		 $.ajax({
				url: "seats",
				data: {
					play_id: '${vo.play_id}',
				},
				success: function(x) {
					location.href ='http://localhost:8888/dorae/seat/seats?play_id=${vo.play_id}', '좌석선택', 'width=1200, height=900, location=no, status=no, scrollbars=yes';
					localStorage.setItem("d_day", $('#selector').val()); 
					localStorage.setItem("d_time", $('.time').val()); //부모 창에서 로컬 스토리지에 정보 저장
				} //success
			}) //ajax - seats 
	}) //b
	
	
}) //$
</script>
</head>
<body>
<!-- 세션이 null이면 로그인 화면창이 뜨게하고 -->
<% if(session.getAttribute("email") == null){%>
out.println("<script> location.href = 'http://localhost:8888/dorae/login/login.jsp';</script>");  
<!-- 세션이 있으면(아이디 비번 정보가 남아있으면) 좌석선택 화면으로 뜨게하기 -->
<%} else{ %>
<%} %> 
<div class="main">
 <div class="content">
  <div class="left">
   <div class="white_box">
   <!-- 달력 -->
    <div class="step1">
	 <strong class="title">
	  <span>날짜선택</span>
	 </strong>
     <div id="selector"></div>
    </div> <!-- step1 -->
    <!-- 시간 -->
    <div class="step2">
	 <strong class="title">
	  <span>시간선택</span>
	 </strong>
	 <select class="time" style="width:200px; height:50px;">
		<option selected disabled="disabled">관람일을 선택해주세요</option>
	 </select>
	</div> <!-- step2 -->
   </div> <!-- white_box -->
    <strong class="title_notice">주의사항</strong>
    <ul class="notice">
     <li>> 1인당 최대 4매까지 구매 가능합니다.</li><br>
     <li>> 결제수단은 카카오페이를 이용한 카드결제만 가능합니다.</li><br>
     <li>> 다시선택 버튼은 선택하신 모든 정보가 초기화됩니다.</li><br>
     <li>> 2매 이상 예매시 결제 부분취소가 불가능 합니다.</li><br>
    </ul>
   </div> <!-- left -->
 
  <div class="right">
   <div class="info">
   <input type="hidden" id="play_id" value="${vo.play_id}">
    <span class="poster">
     <img src="${vo.poster}" width="150" height="180">
    </span>
   </div> <!-- info -->
   <div class="info2">
    <table>
     <caption>예매정보</caption>
     <colgroup>
      <col style="width:70px"><col>
     </colgroup>
     <tfoot>
      <tr>
       <th>총결제</th> 
       <td>0</td> 
      </tr>
     </tfoot>
     <tbody>
      <tr>
       <th>예매일</th>
       <c:set var="today" value="<%=new java.util.Date() %>"/>
       <td id="booking"><fmt:formatDate value="${today}" type="date" pattern="yyyy-MM-dd" /></td>
      </tr>
      <tr>
       <th>공연명</th>
       <td id="play_name"><${vo.genre_name}>${vo.play_name}</td>
      </tr>
      <tr>
       <th>장소</th>
       <td id="place">${vo.stage_name}</td>
      </tr>
      <tr>
       <th>관람날짜</th>
       <td id="d_day"></td>
      </tr>
      <tr>
       <th>관람시간</th>
       <td id="d_time"></td>
      </tr>
      <tr>
       <th>좌석번호</th>
       <td id="seat_num"></td>
      </tr>
      <tr>
       <th>좌석수</th>
       <td id="count">0</td>
      </tr>
      <tr>
       <th>티켓가격</th>
       <td id="price">0</td>
      </tr>
      <tr>
       <th>예매수수료</th>
       <td id="fee">0</td>
      </tr>
     </tbody>
    </table>
   </div> <!-- info2 -->
	 <!-- 날짜, 시간 선택해야 버튼 활성화 -->
   <button disabled="disabled" id="b" name="play_id" value="${vo.play_id}">좌석선택</button>
  </div> <!-- right -->
 </div>	<!-- content -->
</div> <!-- main -->
</body>
</html>