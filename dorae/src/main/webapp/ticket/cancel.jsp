<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매취소</title>
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<!-- 시간 및 날짜 처리를 위한 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/luxon@3.3.0/build/global/luxon.min.js"></script> 
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">

function fillTicketInfo2(seatDate, seatId, paid_amount) {
	$("#seat_date").val(seatDate)
	$("#seat_id").val(seatId)
}



$(function() {
	  //Luxon 라이브러리 사용해서 한국시간으로 바꾸고 YYYY-MM-DD 형식으로 가져옴
	  var today = luxon.DateTime.local().setZone('Asia/Seoul').toISODate();
	  
	$('#cancel').click(function() { //취소버튼 눌렀을 때
		
	 var seatDate = $('#seat_date').val(); //관람날짜
		
	  //공연당일에는 취소 불가능
	  if(seatDate.substring(0, seatDate.indexOf('(')) === today){
		 alert("공연 당일에는 취소가 불가능합니다.")
		 
	   } else{ //당일 아니면 취소 가능
	    	 $.ajax({
					url: "../pay/update", //inner join 사용해서 한번에 변경
					data: {
						email: '${email}',
						seat_id: $('#seat_id').val() //티켓번호
					},
					success: function() {
						alert("예매가 취소되었습니다.");
						window.close();
					}, //success
					error: function() {
						alert("취소에 실패하였습니다.");
					} //error
				}) //ajax
				cancelPay();
	     }// else
	}) //cancle.click
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
<div class="container my-5">
  <div class="p-5 text-center bg-body-tertiary rounded-3">
    <i class="bi bi-exclamation-triangle" style="font-size: 10rem; color: orange;"></i>
    <h2 class="text-body-emphasis">예매취소</h2>
    <p class="col-lg-8 mx-auto fs-5 text-muted">
      정말 취소하시겠습니까??<br>
      취소된 내역은 되돌릴 수 없습니다.
    </p>
    <div class="d-inline-flex gap-2 mb-5">
      <button class="d-inline-flex align-items-center btn btn-outline-warning btn-lg px-4 rounded-pill" id="cancel">
        예매취소
      </button>
      <button class="btn btn-outline-secondary btn-lg px-4 rounded-pill" onclick="window.close()">
        닫기
      </button>
    </div>
  </div>
</div>

<input type="hidden" id="seat_date" >
<input type="hidden" id="seat_id" > 


</body>
</html>