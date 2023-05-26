<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석선택</title>
<link rel="stylesheet" href="../resources/css/seat.css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">

</style>
</head>
<body>
<!-- 세션이 null이면 로그인 화면창이 뜨게하고 -->
<% if(session.getAttribute("email") == null){out.println("<script type='text/javascript'>location.href = 'http://localhost:8888/dorae/login/login.jsp'</script>"); %> 
<!-- 세션이 있으면(아이디 비번 정보가 남아있으면) 좌석선택 화면으로 뜨게하기 -->
<%} else{ %>
<%} %> 
 <input type="hidden" class="class" name="name" id="show_price" value="35000">

    <div class="container">
      <div class="stage"></div>		<!-- 무대 -->
      <div class="row"></div>  <!-- 좌석 -->
    </div>
    
	<div>
      <fieldset>
      <legend>예매정보</legend>
      <img src="${vo.poster}" width="180" height="180"><br>
       <input type="hidden" id="play_id" value="${vo.play_id}">
      <c:set var="today" value="<%=new java.util.Date() %>"/>
	  예매일 <a id="booking"><fmt:formatDate value="${today}" type="date" pattern="yyyy-MM-dd" /></a><br>
      상품명 <span id="play_name">${vo.play_name}</span><br>
      장소 <span id="place">${vo.stage_name}</span><br>
      <hr>
	  관람날짜 <span id="d_day"></span><br>
	  관람시간<span id="d_time"></span><br>
	  좌석번호 <span id="seat_num"></span><br>
	  좌석수 <span id="count">0</span>개<br>
	  </fieldset>
	  
	  <fieldset>
	  <legend>결제정보</legend>
      티켓금액 <span id="price">0</span>원<br>
      예매수수료 <span id="fee">0</span>원<br>
      <hr>
      총결제 <span id="total">0</span>원<br><br>
      </fieldset>
      
      <fieldset id="check" style="display:none;">
      <legend>주문자확인</legend>
	  구매자이름: <input id="name" readonly><br>
	  이메일: <input id="email" readonly><br>
	  전화번호: <input id="tel" placeholder="전화번호 입력해주세요" value="" oninput="phone(this)" maxlength="13"><br>
	  </fieldset>
	  <br>
	<button id="clearBtn" class="clear" >다시선택</button>
    <button id="next">다음단계</button>
    <button id="payment" style="display:none;" disabled="disabled">결제하기</button>
    </div>
 <script type="text/javascript">
$(document).ready(function() { // ajax 사용해서 비동기 통신 할 때 태그의 로드만을 감지, 중복가능
	$('#d_day').text(localStorage.getItem("d_day")); 
	$('#d_time').text(localStorage.getItem("d_time")); 
	
	  $.ajax({
			url: "sold",
			data: {
				play_id: '${vo.play_id}',
				seat_date: $('#d_day').text(),
				seat_time: $('#d_time').text()
			},
			success: function(x) { 
				
				 const num_rows = 20; // 좌석의 행 수
				 const num_cols = 20; // 좌석의 열 수

				  const seatContainer = document.querySelector('.container');
				  const seat_arr = []; // 좌석 요소를 저장할 배열
				  const maxSeats = 4; // 최대 선택 가능한 좌석 수
				  let clickSeats = []; // 선택한 좌석 배열
				  
				  for (let i = 0; i < num_rows; i++) { // 좌석 행 생성
				    const row = document.createElement('div');
				    row.classList.add('row');

				    for (let j = 0; j < num_cols; j++) { //좌석 열 생성
				      const seat = document.createElement('div');
				      seat.classList.add('seat');
				      const seatNum = (1 + i) + "열" + (j + 1) + "번"; // 좌석번호
				      
				      if(x != null) { //(DB에 저장된)예매된 좌석이 null이 아니면 
				    	  let xx = x.slice(1, -1).trim().split(",").map(item => item.trim()); // 첫 번째, 마지막 문자를 제외한 범위의 문자열을 추출하고 배열의 각 요소에 대해 앞뒤 공백 제거
				    	  for (var n = 0; n < xx.length; n++) {
							if(xx[n] === seatNum){
								seat.classList.add('sold');
							}
						}
				      }
				      seat.addEventListener('click', function() { //좌석 클릭 이벤트
				    	  if (this.classList.contains('selected')) {
				              // 클릭된 좌석 다시 클릭하면 선택 해제
				              this.classList.remove('selected');
				              clickSeats = clickSeats.filter((seat) => seat !== seatNum); //seatNum과 일치하지 않는 좌석을 제거하고 새로운 배열생성
				              } else {
				                // 좌석 클릭할 때
				                if (clickSeats.length < maxSeats) { //4개까지 선택가능
				                  this.classList.add('selected');
				                  clickSeats.push(seatNum); // 선택한 좌석 넘버 배열로 push
				                } else {
				                  alert('최대 선택 가능한 좌석 수를 초과했습니다.');
				                } //else
				              } //else
				    	  console.log(clickSeats); 
				    	  seat_num.innerText = clickSeats.sort(); // 좌석번호 오름차순 정렬
				    	  updateSelectedCount(); // total과 count 업데이트
				        }); //seat.addEventListener
				     
				      row.appendChild(seat);
				      seat_arr.push(seat); //좌석 배열에 저장
				    } //for(seat)
				    seatContainer.appendChild(row);
				  } //for(row)
			} //success - seats2
		}) //ajax - seats2 
}); //$

const seats = document.querySelectorAll('.row .seat:not(.sold)'); //sold가 아닌 seat와 row를 seats변수에 저장
let ticketPrice = $('#show_price').val(); 

// total과 count 업데이트
function updateSelectedCount() {

	// 좌석 클릭 이벤트로 선택된 좌석을 selectedSeats로 저장시킨다.
  const selectedSeats = document.querySelectorAll('.row .seat.selected');

	// 앞서 초기화했던 변수 selectedSeats들을 [...selectedSeats]로 스프레드 문법을 사용해 개별적 값을 만든 후, 배열로 만든다.  
	// map을 통해 반복문을 돌며 배열 안의 요소들을 [...seats].indexOf(seat)와 1대 1로 짝지어준다.
  const seatsIndex = [...selectedSeats].map(seat => { return [...seats].indexOf(seat); });
  
  	// 선택된 좌석의 배열 개수
  const selectedSeatsCount = selectedSeats.length;
  
	// text부분에 나타낼 정보(선택된 좌석, 가격, 수수료, 총 합계)
  $('#count').text(selectedSeatsCount);
  $('#price').text(selectedSeatsCount * ticketPrice);
  $('#fee').text(selectedSeatsCount * 1000);
  $('#total').text(selectedSeatsCount * ticketPrice + selectedSeatsCount * 1000);
};

$('#next').click(function() { 
	alert("주문정보 확인해주세요")
	$.ajax({
		url: "memberOne", 
		data: {
			email: '${email}' //email가지고 이름 불러오기
		},
		success: function(x) {
			$('#name').val(x) 
			$('#email').val('${email}')
			$('#check').show(); //정보확인칸 띄우기
			$('#next').hide(); //다음버튼 숨기기
		} //success
	}) //ajax
}); //next.click

$('#tel').on('input', function() { //전화번호 입력해야 결제버튼 생성
	if($('#tel').val() != "") {
		$('#payment').show(); //결제버튼 띄우기
		$('#payment').attr("disabled", false); //클릭가능
	} else {
		$('#payment').attr("disabled", true); //클릭불가능
	}
}); //tel.input

function phone(target) { //전화번호 정규식 표현
    target.value = target.value
        .replace(/[^0-9]/g, '') //숫자를 제외한 모든 문자 제거(= 숫자 외에는 입력 불가) g = 전역검색
        .replace(/(^01.{1}|[0-9]{2,3})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3"); //$1-$2-$3패턴으로 재구성 
}

$('#clearBtn').click(function() {
	if(confirm('선택하신 모든 정보가 사라집니다')){
		location.reload();
	} else {
	}
}); // 다시선택

</script>
  
<script type="text/javascript" src="../resources/js/pay.js"></script>
</body>
</html>