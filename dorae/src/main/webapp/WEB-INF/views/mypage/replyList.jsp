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
    width: 100%;
    display: flex;
    justify-content: center;
    background: white;
    padding: 10px 0;
    /* box-shadow: 0px -2px 5px 0px rgba(0,0,0,0.1); */
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
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
    $(".page-number").on("click", function(e) {
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
    });
});
</script>
          <div id="contentDiv">
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
           </div>
    
  

	<script>
		function openEditPopup(rNumber, text) {
			var editUrl = "../mypage/replyEditPopup.jsp?r_number=" + rNumber + "&text=" + encodeURIComponent(text);
			var popupWindow = window.open(editUrl, "replyEditPopup", "width=500,height=400,scrollbars=yes");
			popupWindow.focus();
		}
		function deleteReply(rNumber) {
	        var confirmation = confirm("삭제하시겠습니까?");
	        if (confirmation) {
	            var deleteUrl = "../mypage/replyDelete?r_number=" + rNumber;
	            location.href = deleteUrl;
	        }
	    }
	</script>