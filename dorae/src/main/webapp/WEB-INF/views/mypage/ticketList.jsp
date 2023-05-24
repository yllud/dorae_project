<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <table>
        <thead>
            <tr>
                <th>티켓번호</th>
                <th>공연명</th>
                <th>예매일</th>
                <th>관람일</th>
                <th>공연장소</th>
                <th>결제금액</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="ticket">
                <tr>
                    <td>${ticket.seat_id}</td>
                    <td>${ticket.play_name}</td>
                    <td>${ticket.booking}</td>
                    <td>${ticket.seat_date} ${ticket.seat_time}</td>
                    <td>${ticket.stage_name}</td>
                    <td>${ticket.paid_amount}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
