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
   /*  $(".page-number").on("click", function(e) {
        e.preventDefault();

        // Get the page number from the clicked button
        var pageNumber = $(this).text();

        // Send an AJAX request with the page number
        $.ajax({
            url: "../mypage/replyList2",
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
    }); */
});
</script>
	<table>
        <tr>
            <th>글번호</th>
            <th>공연이미지</th>
            <th>공연이름</th>
            <th>공연날짜</th>
            <th>공연장</th>
        </tr>

        <!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
        <c:forEach items="${list}" var="reply">
            <tr>
                <td>${reply.r_number}</td>
                <td>${reply.score}</td>
                <td>${reply.play_id}</td>
                <td>${reply.play_name}</td>
                <td>${reply.text}</td>
                <td><button onclick="deleteBook(${reply.r_number})">삭제</button></td>
            </tr>
        </c:forEach>
 
    </table>