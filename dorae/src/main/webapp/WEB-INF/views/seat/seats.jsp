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

 <input type="hidden" class="class" name="name" id="show_price" value="35000">

    <div class="container">
      <div class="stage"></div>		<!-- 무대 -->
 
      <div class="row"></div>  <!-- 좌석 -->
</div>

    <p class="text">
      <span id="play_name">${vo.play_name}</span><br>
      <c:set var="today" value="<%=new java.util.Date() %>"/>
	  예매일 <a id="booking"><fmt:formatDate value="${today}" type="date" pattern="yyyy-MM-dd" /></a><br>
	  관람일시 <span id="day_time"></span><br>
	  좌석수 <span id="count">0</span>개<br>
	  좌석번호 <span id="seat_num"></span><br>
      티켓가격 <span id="price">0</span>원<br>
      수수료 <span id="fee">0</span>원<br>
      총결제 <span id="total">0</span>원<br>
      
	  구매자이름: <input id="name" value="이아람"><br>
	  전화번호: <input id="tel" value="010-4808-1750"><br>
	  이메일: <input id="email" value="ahryee@hanmail.net"><br>
    </p>
    <button id="clearBtn" class="clear" onclick='location.reload()'>다시선택</button>
    
    <button type="submit" id="payment">결제하기</button>
    
   <script type="text/javascript">
$(document).ready(function() { // ajax 사용해서 비동기 통신 할 때 태그의 로드만을 감지, 중복가능
	  day_time.innerText = localStorage.getItem("day_time"); //자식 창 로컬 스토리지 정보를 가져옴
	  const num_rows = 6; // 좌석의 행 수
	  const num_cols = 8; // 좌석의 열 수

	  const seatContainer = document.querySelector('.container');
	  const seats = []; // 좌석 요소를 저장할 배열
	  const maxSeats = 4; // 최대 선택 가능한 좌석 수
	  let selectedSeats = []; // 선택한 좌석 배열
	  
	  for (let i = 0; i < num_rows; i++) { // 좌석 행 생성
	    const row = document.createElement('div');
	    row.classList.add('row');

	    for (let j = 0; j < num_cols; j++) { //좌석 열 생성
	      const seat = document.createElement('div');
	      seat.classList.add('seat');
	      const seatNum = String.fromCharCode(65 + i) + "열" + " " + (j + 1); // 좌석이름(65(ASCII 코드) = A >> A1,A2,B1,B2...)
	   
	     
	      
	      seat.addEventListener('click', function() { //좌석 클릭 이벤트
	    	  if (this.classList.contains('selected')) {
	              // 클릭된 좌석 다시 클릭하면 선택 해제
	              this.classList.remove('selected');
	              selectedSeats = selectedSeats.filter((seat) => seat !== seatNum); //seatNum과 일치하지 않는 좌석을 제거하고 새로운 배열생성
	              } else {
	                // 좌석 클릭할 때
	                if (selectedSeats.length < maxSeats) { //4개까지 선택가능
	                  this.classList.add('selected');
	                  selectedSeats.push(seatNum); // 선택한 좌석 넘버 배열로 push
	                } else {
	                  alert('최대 선택 가능한 좌석 수를 초과했습니다.');
	                } //else
	              } //else
	    	  console.log(selectedSeats); 
	    	  seat_num.innerText = selectedSeats.sort(); // 좌석번호 오름차순 정렬
	    	  updateSelectedCount();
	        }); //seat.addEventListener
	     
	      row.appendChild(seat);
	      seats.push(seat); //좌석 배열에 저장
	    } //for(seat)
	    seatContainer.appendChild(row);
	  } //for(row)
}); //$
const seats = document.querySelectorAll('.row .seat:not(.sold)'); // 배열과 비슷한 객체인 nodeList를 반환 -  for문 또는 forEach문을 사용
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
</script>
<script type="text/javascript" src="../resources/js/pay.js"></script>
</body>
</html>