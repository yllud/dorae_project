<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

     <c:forEach items="${list}" var="ticket">
	    <table style="width: 500px; float: left; font-size: 14px; font-family:sans-serif; margin-right: 30px; margin-bottom: 5px; border-collapse: collapse;">
	    <tr style="border-bottom: 1px solid #bababa ;">
	    	<td colspan=3 style="height:50px"><span style="font-size: 18px; font-weight: bold; ">&nbsp;&nbsp;&nbsp;&nbsp;공연명: ${ticket.play_name}</span>&nbsp;&nbsp; ${ticket.play_id}
	    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    	<button onclick="openPopup('${ticket.play_id}', '${ticket.play_name}', '${ticket.seat_date}', '${ticket.seat_time}', '${ticket.seat_id}')">후기작성</button>
	    	<button id="cancel" onclick="openPopup2('${ticket.seat_date}', '${ticket.seat_id}')">예매취소</button>
	    	</td>
	    </tr>
	    <tr>
	    	<td rowspan=5 style="padding-top:8px; text-align: center;"><img style="width: 150px; height: 170px" alt="${ticket.play_name}" src="${ticket.poster}"></td>
	    	<td style="padding-left: 3px; font-style: ">티켓번호</td>
	    	<td style="padding-left: 3px">${ticket.seat_id}</td>
	    </tr>
	        <tr>
	    	<td style="padding-left: 3px">예매일</td>
	    	<td style="padding-left: 3px">${ticket.booking}</td>
	    </tr>
	        <tr>
	    	<td style="padding-left: 3px">관람일</td>
	    	<td style="padding-left: 3px">${ticket.seat_date}&nbsp;${ticket.seat_time}</td>
	    </tr>
	        <tr>
	    	<td style="padding-left: 3px">공연장소</td>
	    	<td style="padding-left: 3px">${ticket.stage_name}</td>
	    </tr>
	        <tr>
	    	<td style="padding-left: 3px">결제금액</td>
	    	<td style="padding-left: 3px">${ticket.paid_amount}</td>
	    </tr>
	    </table>
    </c:forEach>

    </div>
    
    <script>
 // 후기 작성 버튼 클릭 시 팝업 창을 열고 티켓 정보 전달
    function openPopup(playId, playName, seatDate, seatTime, seatId) {
        var popupWindow = window.open("../mypage/replyPopup.jsp", "popupWindow", "width=500,height=500");
        popupWindow.onload = function() {
            popupWindow.fillTicketInfo(playId, playName, seatDate, seatTime, seatId);
        };
    }
 // 후기 작성 버튼 클릭 시 팝업 창을 열고 티켓 정보 전달(예매취소)
    function openPopup2(seatDate, seatId) {
        var popupWindow2 = window.open("../ticket/cancel.jsp", "popupWindow2", "width=500,height=500");
        popupWindow2.onload = function() {
            popupWindow2.fillTicketInfo2(seatDate, seatId);
        };
    }
    </script>