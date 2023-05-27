<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="resources/js/jquery-3.6.4.js"></script>

    <table>
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
    </table>
    
    <script>
 // 후기 작성 버튼 클릭 시 팝업 창을 열고 티켓 정보 전달
    function openPopup(playId, playName, seatDate, seatTime, seatId) {
        var popupWindow = window.open("../mypage/replyPopup.jsp", "popupWindow", "width=500,height=500");
        popupWindow.onload = function() {
            popupWindow.fillTicketInfo(playId, playName, seatDate, seatTime, seatId);
        };
    }
    </script>