<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<table>
        <tr>
            <th>r_number</th>
            <th>play_id</th>
            <th>text</th>
            <th>booking</th>
            <th>seat_date</th>
            <th>imp_uid</th>
            <th>email</th>
            <th>upload_date</th>
        </tr>
        <!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
        <c:forEach items="${list}" var="reply">
            <tr>
                <td>${reply.r_number}</td>
                <td>${reply.play_id}</td>
                <td>${reply.text}</td>
                <td>${reply.booking}</td>
                <td>${reply.seat_date}</td>
                <td>${reply.imp_uid}</td>
                <td>${reply.email}</td>
                <td>${reply.upload_date}</td>
            </tr>
        </c:forEach>
    </table>