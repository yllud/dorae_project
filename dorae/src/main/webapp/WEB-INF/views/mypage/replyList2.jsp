<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<table>
        <tr>
            <th>글번호</th>
            <th>평점</th>
            <th>공연id</th>
            <th>공연명</th>
            <th>내용</th>
            <th>공연날짜</th>
            <th>티켓번호</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th></th>
            <th></th>
        </tr>

        <!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
        <c:forEach items="${list}" var="reply">
            <tr>
                <td style="font-size: 15px; width: 60px;">${reply.r_number}</td>
                <td style="font-size: 15px; width: 50px;">${reply.score}</td>
                <td style="font-size: 13px; width: 75px;">${reply.play_id}</td>
                <td style="font-weight: bold; font-size: 15px; width: 120px;">${reply.play_name}</td>
                <td style="font-size: 15px; width: 150px;">${reply.text}</td>
                <td style="font-size: 13px; width: 120px;">${reply.seat_date} ${reply.seat_time}</td>
                <td style="font-size: 13px; width: 100px;">${reply.seat_id}</td>
                <td style="font-size: 15px; width: 100px;">${reply.nickname}</td>
                <td style="font-size: 13px; width: 100px;">${reply.upload_date}</td>
                <td style="width: 50px;"><button onclick="openEditPopup('${reply.r_number}', '${reply.text}')">수정</button></td>
                <td style="width: 50px;"><button onclick="deleteReply(${reply.r_number})">삭제</button></td>
            </tr>
        </c:forEach>
    
    </table>
