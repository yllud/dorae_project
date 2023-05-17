<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/seat.css">
<title>좌석선택</title>
<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
	
	  const num_rows = 6; // 좌석의 행 수
	  const num_cols = 8; // 좌석의 열 수

	  const seatContainer = document.querySelector('.container');
	  const seats = []; // 좌석 요소를 저장할 배열
	  const maxSeats = 4; // 최대 선택 가능한 좌석 수
	  let selectedSeats = []; // 선택된 좌석 배열
	  
	  for (let i = 0; i < num_rows; i++) {
	    const row = document.createElement('div');
	    row.classList.add('row');

	    for (let j = 0; j < num_cols; j++) {
	      const seat = document.createElement('div');
	      seat.classList.add('seat');
	      const seatNum = String.fromCharCode(65 + i) + (j + 1); // 좌석이름(65(ASCII 코드) = A >> A1,A2,B1,B2...)
	      
	      seat.addEventListener('click', function() { //좌석 클릭했을 때 
	    	  if (this.classList.contains('selected')) {
	              // 이미 선택된 좌석인 경우 선택 해제
	              this.classList.remove('selected');
	              selectedSeats = selectedSeats.filter((seat) => seat !== seatNum);
	            } else {
	                // 선택되지 않은 좌석인 경우 선택
	                if (selectedSeats.length < maxSeats) {
	                  this.classList.add('selected');
	                  selectedSeats.push(seatNum);
	                } else {
	                  alert('최대 선택 가능한 좌석 수를 초과했습니다.');
	                }
	              }
	    	  console.log(selectedSeats);
	    	  seat_num.innerText = selectedSeats.sort(); // 좌석번호 오름차순 정렬
	    	  
	        });
	     
	      row.appendChild(seat);
	      seats.push(seat); //좌석 배열에 저장
	    }
	    seatContainer.appendChild(row);
	  }
	});

    




</script>
</head>
<body>
<select id="show">
 <option value="35000">${vo.play_name}</option>
</select>

    <div class="container">
      <div class="stage"></div>		<!-- 무대 -->
 
      <div class="row"></div>  <!-- 좌석 -->
	</div>

    <p class="text">
      <c:set var="today" value="<%=new java.util.Date() %>"/>
	  예매일 <a id="booking"><fmt:formatDate value="${today}" type="date" pattern="yyyy-MM-dd" /></a><br>
	  관람날짜 <span id="day_time"></span><br>
	  좌석위치 <span id="seat_num"></span><br>
	  선택된 좌석 <span id="count">0</span>개<br>
      가격 <span id="price">0</span>원<br>
      수수료 <span id="fee">0</span>원<br>
      총 결제금액 <span id="total">0</span>원<br>
      
	  구매자이름: <input id="name" value="이아람"><br>
	  전화번호: <input id="tel" value="010-4808-1750"><br>
	  이메일: <input id="email" value="ahryee@hanmail.net"><br>
     
    </p>
    <button id="clearBtn" class="clear" onClick="location.reload()">새로고침</button>
    <button type="submit" id="b">결제하기</button>
    
    <script src="resources/js/seat.js"></script>
</body>
</html>