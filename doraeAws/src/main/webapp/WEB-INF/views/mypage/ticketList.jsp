<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 페이징 버튼을 감싸는 div를 추가 -->
<div id="page-buttons">
<%
    int pages = (int) request.getAttribute("pages");
%>
    <% for (int p = 1; p <= pages; p++) { %>
        <button class="page-number"><%= p %></button>
    <% } %>
</div>

<style>
#contentDiv button {
    background-color: #ff9900;
    color: #fff;
    padding: 4px 8px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

/* 페이지 버튼을 하단에 고정하고 가운데 정렬하기 위한 CSS 추가 */
#page-buttons {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    display: flex;
    justify-content: center;
    background: white;
    padding: 10px 0;
}
</style>
<style>
#contentDiv button {
	background-color: #ff9900;
	color: #fff;
	padding: 4px 8px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}
</style>
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
    $(".page-number").on("click", function(e) {
        e.preventDefault();

        // Get the page number from the clicked button
        var pageNumber = $(this).text();

        // Send an AJAX request with the page number
        $.ajax({
            url: "../mypage/ticketList2",
            type: "GET",
            data: { page: pageNumber },
            success: function(response) {
                // Update the div with the retrieved content
                $("#contentDiv").html(response);
            },
            error: function() {
                console.log("Error occurred while fetching page data.");
            }
        });
    });
});
</script>
          <div id="contentDiv">

<%--      <table>
        <thead>
            <tr>
                <th>티켓번호</th>
                <th>공연id</th>
                <th>공연명</th>
                <th>예매일</th>
                <th>관람일</th>
                <th>공연장소</th>
                <th>결제금액</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="ticket">
                <tr>
                    <td>${ticket.seat_id}</td>
                    <td>${ticket.play_id}</td>
                    <td>${ticket.play_name}</td>
                    <td>${ticket.booking}</td>
                    <td>${ticket.seat_date} ${ticket.seat_time}</td>
                    <td>${ticket.stage_name}</td>
                    <td>${ticket.paid_amount}</td>
                    <td><button onclick="openPopup('${ticket.play_id}', '${ticket.play_name}', '${ticket.seat_date}', '${ticket.seat_time}', '${ticket.seat_id}')">후기작성</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>  --%>
    
    <c:forEach items="${list}" var="ticket">
	    <table style="width: 500px; float: left; font-size: 14px; font-family:sans-serif; margin-right: 30px; margin-bottom: 5px; border-collapse: collapse;">
	    <tr style="border-bottom: 1px solid #bababa ;">
	    	<td colspan=3 style="height:50px">
	    	<table>
	    	<tr>
	    	<td>
	    	

	    	<span style="font-size: 18px; font-weight: bold; ">
	    	&nbsp;&nbsp;&nbsp;&nbsp;공연명: ${ticket.play_name}</span>&nbsp;&nbsp; ${ticket.play_id}
	   		</td>
	    	<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
	    	<td width="30%">
	    	<div align="right">
	    	<button onclick="openPopup('${ticket.play_id}', '${ticket.play_name}', '${ticket.seat_date}', '${ticket.seat_time}', '${ticket.seat_id}')">후기작성</button>
	    	<button id="cancel" onclick="openPopup2('${ticket.seat_date}', '${ticket.seat_id}')">예매취소</button>
	    	</div>
	    	</td>
	    	</tr>
	    	</table>
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
        var popupWindow2 = window.open("../ticket/cancel.jsp", "popupWindow2", "width=500,height=650, left=500, top=400");
        popupWindow2.onload = function() {
            popupWindow2.fillTicketInfo2(seatDate, seatId);
        };
    }
    </script>