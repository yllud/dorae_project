<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    int pages = (int) request.getAttribute("pages");
    for (int p = 1; p <= pages; p++) {
%>

        <button class="page-number"><%= p %></button>

<% } %>

<script type="text/javascript" src="resources/js/jquery-3.6.4.js"></script>
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
	    <table style="width: 500px; float: left; font-size: 14px; font-family:sans-serif; margin-right: 10px; margin-bottom: 5px; border-collapse: collapse;">
	    <tr style="border-bottom: 1px solid #bababa ;">
	    	<td colspan=3 style="height:50px"><span style="font-size: 18px; font-weight: bold; ">공연명: ${ticket.play_name}</span>&nbsp;&nbsp; ${ticket.play_id}
	    	<button onclick="openPopup('${ticket.play_id}', '${ticket.play_name}', '${ticket.seat_date}', '${ticket.seat_time}', '${ticket.seat_id}')">후기작성</button></td>
	    </tr>
	    <tr>
	    	<td rowspan=5 style="padding-top:8px; text-align: center;"><img style="width: 150px; height: 170px" alt="${ticket.play_name}" src="${ticket.image}"></td>
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
    </script>