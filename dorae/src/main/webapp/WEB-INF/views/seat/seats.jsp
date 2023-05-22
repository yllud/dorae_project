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

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
  <script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>
<!-- 세션이 null이면 로그인 화면창이 뜨게하고 -->
<% if(session.getAttribute("email") == null){out.println("<script type='text/javascript'>location.href = 'http://localhost:8887/dorae/login/login.jsp'</script>"); %> 
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
      
      <fieldset>
      <legend>주문자확인</legend>
	  구매자이름: <input id="name" value="${member.name}"><br>
	  전화번호: <input id="tel" ><br>
	  이메일: <input id="email" readonly ><br>
	  </fieldset>
	  <br>
	<button id="clearBtn" class="clear" onclick='location.reload()'>다시선택</button>
    <button type="submit" id="next">다음단계</button>
    <button type="submit" id="payment">결제하기</button>
    </div>
 <script type="text/javascript">
$(document).ready(function() { // ajax 사용해서 비동기 통신 할 때 태그의 로드만을 감지, 중복가능
	d_day.innerText = localStorage.getItem("d_day"); 
	d_time.innerText = localStorage.getItem("d_time"); //부
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
	      const seatNum = (1 + i) + "열" + " " + (j + 1) + "번"; // 
	      
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
	        
	         /* $('#next').click(function() { // 다음버튼 눌렀을 때 선택되어 있는 좌석 sold로 변경(선택x)
	        	if (seat.classList.contains('selected')) {
	        		seat.classList.add('sold');
	        		seat.classList.remove('selected');
	        		clickSeats.pop(seatNum);
	        		seat_num.innerText = clickSeats; 
	        		updateSelectedCount();
	        	} //if 
	        	
	        }) //next버튼 */
	        
	      row.appendChild(seat);
	      seat_arr.push(seat); //좌석 배열에 저장
	    } //for(seat)
	    seatContainer.appendChild(row);
	  } //for(row)
}); //$

const seats = document.querySelectorAll('.row .seat:not(.sold)'); 
const count = document.getElementById('count');
const price = document.getElementById('price');
const fee = document.getElementById('fee');
const total = document.getElementById('total'); 
const show_price = document.getElementById('show_price');
let ticketPrice = show_price.value; 

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
  count.innerText = selectedSeatsCount;
  price.innerText = selectedSeatsCount * ticketPrice;
  fee.innerText = selectedSeatsCount * 1000;
  total.innerText = selectedSeatsCount * ticketPrice + selectedSeatsCount * 1000;
}

$('#next').click(function() {
	alert("회원정보 확인해주세요")
	$.ajax({
		url: "memberOne",
		data: {
			email: '${email}'
		},
		success: function(x) {
			$('#email').val('${email}')
		}
	})
})
</script>
  
<script type="text/javascript" src="../resources/js/pay.js"></script>
</body>
</html>