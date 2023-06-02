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
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>
<input type="hidden" class="class" name="name" id="show_price" value="35000">
<div class="main">
 <div class="content">
   <div class="left">
    <div class="white_box">
    <div class="container2">
      <div class="stage"></div>		<!-- 무대 -->
      <div class="row2"></div>  <!-- 좌석 -->
    </div>
   
    <div class="check" style="display:none;">
     <div class="step1">
	  <strong class="title">
	   <i class="bi bi-ticket"></i>
	   <span>티켓수령방법</span>
	  </strong>
     <input value="현장수령" type="text" class="form-control mt-3" readonly><br>
    </div> <!-- step1 -->
    
    <div class="step2">
	 <strong class="title">
	  <i class="bi bi-clipboard-check"></i>
	  <span>주문자정보</span><br>
	 </strong>
	 <i class="bi bi-person"></i>
	  이름 <input id="name" type="text" class="form-control mt-3" readonly ><br>
	  <i class="bi bi-envelope"></i>
	  이메일 <input id="email" type="text" class="form-control mt-3" readonly><br>
	  <i class="bi bi-phone"></i>
	  휴대폰 번호 <input id="tel" type="text" class="form-control mt-3" placeholder="숫자만 입력해주세요" value="" oninput="phone(this)" maxlength="13"><br>
    </div> <!-- step2 -->
   </div> <!-- check -->
   </div> <!-- white_box -->
   <button id="clearBtn" class="btn btn-outline-secondary"><i class="bi bi-arrow-repeat"></i></button> <!-- 새로고침버튼 -->
  </div> <!-- left -->
	
  <div class="right">
   <div class="info">
   <input type="hidden" id="play_id" value="${vo.play_id}">
    <span class="poster">
     <img src="${vo.poster}" width="150" height="180"><br>
    </span>
   </div> <!-- info -->
   <div class="info2">
    <table>
     <colgroup>
      <col style="width:70px"><col>
     </colgroup>
     <tfoot>
      <tr>
       <th>총결제</th> 
       <td id="total">0</td>
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
	 <button class="btn btn-outline-secondary btn-lg" style="--bs-btn-padding-x: 1.2rem;" onclick="history.back()"><i class="bi bi-arrow-left"></i>날짜선택</button>
     <button id="next" class="btn btn-outline-secondary btn-lg"  style="--bs-btn-padding-x: 1.2rem;" disabled="disabled">다음 <i class="bi bi-arrow-right"></i></button>
     <button id="payment" class="btn btn-outline-danger btn-lg" style="display:none; --bs-btn-padding-x: 1.4rem;" disabled="disabled">결제 <i class="bi bi-arrow-right"></i></button>
  </div> <!-- right -->
 </div>
</div>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel"><i class="bi bi-info-circle" style="color: orange;"></i> 안내</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        선택하신 좌석 정보가 사라집니다
      </div>
      <div class="modal-footer">
        <button id="ok" class="btn btn-outline-secondary" data-bs-dismiss="modal">확인</button>
        <button id="no" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
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

				  const seatContainer = document.querySelector('.container2');
				  const seat_arr = []; // 좌석 요소를 저장할 배열
				  const maxSeats = 4; // 최대 선택 가능한 좌석 수
				  let clickSeats = []; // 선택한 좌석 배열
				  
				  for (let i = 0; i < num_rows; i++) { // 좌석 행 생성
				    const row2 = document.createElement('div');
				    row2.classList.add('row2');

				    for (let j = 0; j < num_cols; j++) { //좌석 열 생성
				      const seat = document.createElement('div');
				      seat.classList.add('seat');
				      const seatNum = (1 + i) + "열" + (j + 1) + "번"; // 좌석번호
				      
				      // Bootstrap 툴팁 설정
				      seat.setAttribute('data-bs-toggle', 'tooltip');
				      seat.setAttribute('data-bs-placement', 'top');
				      seat.setAttribute('title', seatNum);

				      // seat 마우스 오버 이벤트 핸들러 추가
				      seat.addEventListener('mouseover', function() {
				        $(this).tooltip('show');
				      });

				      // seat 마우스 아웃 이벤트 핸들러 추가
				      seat.addEventListener('mouseout', function() {
				        $(this).tooltip('hide');
				      });
				      
				      if(x != null) { //(DB에 저장된)예매된 좌석이 null이 아니면 
				    	  let xx = x.slice(1, -1).trim().split(",").map(item => item.trim()); // 첫 번째, 마지막 문자를 제외한 범위의 문자열을 추출하고 배열의 각 요소에 대해 앞뒤 공백 제거
				    	  for (var n = 0; n < xx.length; n++) {
							if(xx[n] === seatNum){
								seat.classList.add('sold'); //sold로 클래스 추가해서 선택못하도록 만들기
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
				                  alert('최대 4자리까지 선택가능합니다.');
				                } //else
				              } //else
				    	  console.log(clickSeats); 
				    	  seat_num.innerText = clickSeats.sort(); // 좌석번호 오름차순 정렬
				    	  updateSelectedCount(); // total과 count 업데이트
				        }); //seat.addEventListener
				     
				      row2.appendChild(seat);
				      seat_arr.push(seat); //좌석 배열에 저장
				    } //for(seat)
				    seatContainer.appendChild(row2);
				  } //for(row)
			} //success - seats2
		}) //ajax - seats2 
}); //$

const seats = document.querySelectorAll('.row2 .seat:not(.sold)'); //sold가 아닌 seat와 row를 seats변수에 저장
let ticketPrice = $('#show_price').val(); 

// total과 count 업데이트
function updateSelectedCount() {

	// 좌석 클릭 이벤트로 선택된 좌석을 selectedSeats로 저장시킨다.
  const selectedSeats = document.querySelectorAll('.row2 .seat.selected');

	// 앞서 초기화했던 변수 selectedSeats들을 [...selectedSeats]로 스프레드 문법을 사용해 개별적 값을 만든 후, 배열로 만든다.  
	// map을 통해 반복문을 돌며 배열 안의 요소들을 [...seats].indexOf(seat)와 1대 1로 짝지어준다.
  const seatsIndex = [...selectedSeats].map(seat => { return [...seats].indexOf(seat); });
  
  	// 선택된 좌석의 배열 개수
  const selectedSeatsCount = selectedSeats.length;
    if(selectedSeatsCount != 0){ 
		$('#next').attr("disabled", false); //다음버튼 활성화
	}else{
		$('#next').attr("disabled", true); //다음버튼 비활성화
	}
  
	// text부분에 나타낼 정보(선택된 좌석, 가격, 수수료, 총 합계)
  $('#count').text(selectedSeatsCount);
  $('#price').text(selectedSeatsCount * ticketPrice + " " + "원");
  $('#fee').text(selectedSeatsCount * 1000 + " " + "원");
  $('#total').text(selectedSeatsCount * ticketPrice + selectedSeatsCount * 1000 + " " + "원");
};


$(function() {
	$('#next').click(function() { //다음단계버튼
		$.ajax({
			url: "sold",
			data: {
				play_id: '${vo.play_id}',
				seat_date: $('#d_day').text(),
				seat_time: $('#d_time').text()
			},
			success: function(res) { 
				let res2 = res.slice(1, -1).trim().split(",").map(item => item.trim());
				for (var m = 0; m < res2.length; m++) {
					if ($('#seat_num').text() === res2[m]){ //누군가 예매했다면
						alert("이미 선택된 좌석입니다");
						location.reload();	
					} else { //예매가능하다면
						$.ajax({
							url: "memberOne", 
							data: {
								email: '${email}' //email가지고 이름 불러오기
							},
							success: function(x) {
								const x2 = x.split(",");
								var name = x2[0]; 
								var nickname = x2[1];
								if (name) { //회원정보에 이름 있으면 이름사용(네이버)
									$('#name').val(name);
								} else { //이름 없으면 닉네임사용(카카오)
									$('#name').val(nickname);
								}
								$('.container2').empty();
								$('#email').val('${email}');
								$('.container2').append($('.check').show()); //정보확인칸 띄우기
								$('#next').hide(); //다음버튼 숨기기 
								$('#payment').show(); //결제버튼 띄우기
							} //success
						}) //ajax
					} //else
				} //for
			}, //success
			error: function() {
				alert("다시 선택해 주세요");
				location.reload();
			} //error
		}); //ajax
	}); //next.click
}); //function


$('#tel').on('input', function() { //전화번호 입력해야 결제버튼 생성
	if($('#tel').val().length >= 11 && $('#tel').val().length <= 13) { //13자리일때
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

$('#clearBtn').click(function() { //새로고침
	$('#staticBackdrop').modal('show');
});
$('#ok').click(function() { //모달창 '확인' 클릭
	location.reload();		
});
$('#no').click(function() { //모달창 '취소' 클릭
	$('#staticBackdrop').modal('hide');	
});
	
$('#payment').click(function() { //결제
	$.ajax({
		url: "sold",
		data: {
			play_id: '${vo.play_id}',
			seat_date: $('#d_day').text(),
			seat_time: $('#d_time').text()
		},
		success: function(result) { 
			let result2 = result.slice(1, -1).trim().split(",").map(item => item.trim());
			for (var k = 0; k < result2.length; k++) {
				if ($('#seat_num').text() === result2[k]){ //누군가 예매했다면
					alert("이미 선택된 좌석입니다");
					location.reload();	
				} else { //예매가능하다면
					pay(); 
				} //else
			} //for
		} //success
	}); //ajax
}); //payment

function pay() {	
	var IMP = window.IMP; // 생략가능
	IMP.init('imp60843063'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	IMP.request_pay({//******* API : 함수를 불러서 처리해 달라고 할 때 사용하는 함수의 집합
		pg : 'kakaopay', // version 1.1.0부터 지원.
		pay_method : 'card',
		merchant_uid : 'merchant_' + new Date().getTime(),
		name : '결제테스트',
		amount : $("#total").text(),
		buyer_name : $("#name").val(),
		buyer_tel : $("#tel").val(),
		buyer_email : $("#email").val(),
		m_redirect_url : 'www.yourdomain.com/payments/complete'
	}, function(rsp) {
		if (rsp.success) {
			$.ajax({
				url: "insert", // 티켓정보(seatDB)
				data: { 
					email: $('#email').val(), //회원e-mail
					play_id: $('#play_id').val(), //공연ID
					seat_date: $('#d_day').text(), //공연날짜
					seat_time: $('#d_time').text(), //공연시간
					seat_number: $('#seat_num').text(), //좌석번호
					//seat_id: 티켓번호(pk) 자동생성 됨
					imp_uid: rsp.imp_uid, //결제고유번호
			    	merchant_uid: rsp.merchant_uid, //주문번호
			    	apply_num: rsp.apply_num, //결제카드번호
			    	paid_amount: rsp.paid_amount, //결제금액
			    	buyer_name: rsp.buyer_name, //주문자 이름
			    	buyer_tel: rsp.buyer_tel, //주문자 전화번호
			    	email: rsp.buyer_email, //주문자 이메일
			    	play_id: $('#play_id').val(), //공연ID
			    	booking: $('#booking').text(),//예매일
			    	//seat_id: 티켓번호(fk) 자동생성 됨
				 },
				success: function() {
					var msg = '결제가 완료되었습니다.';
	    			alert(msg);
	    			location.href = "../test.jsp";
				 }, //success 
				error: function() {
					alert("결제에 실패하였습니다.");
					location.reload();
				 } //error
			  }); //ajax 
		   } else {
		     var msg = '결제에 실패하였습니다.';
		     alert(msg);
		     location.reload();
		   } //else
	  }); //IMP.request_pay
}; //pay
</script>

<!-- <script type="text/javascript" src="../resources/js/pay.js"></script> -->
</body>
</html>