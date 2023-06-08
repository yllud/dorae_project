<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    int pages = (int) request.getAttribute("pages");
%>

<!-- 페이징 버튼을 감싸는 div를 추가 -->
<div id="page-buttons">
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
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
    $(".page-number").on("click", function(e) {
        e.preventDefault();

        // Get the page number from the clicked button
        var pageNumber = $(this).text();

        // Send an AJAX request with the page number
        $.ajax({
            url: "../mypage/reviewList2",
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
<%-- JSP 파일에서 데이터 출력 --%>
<table>
        <tr>
            <th>글번호</th>
            <th>제목</th>
            <th>내용</th>
        </tr>
        <!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
        <c:forEach items="${list}" var="review">
            <tr>
                <td style="font-size: 15px; width: 50px; text-align: center;">${review.review_id}</td>
                <td style="font-weight: bold; font-size: 15px; width: 150px; text-align: center;"><a href="../review/detail?id=${review.review_id}">${review.review_title}</a></td>
                <td style="font-size: 15px; width: 150px; text-align: center;">${review.review_content}</td>
            </tr>
        </c:forEach>
    </table>
    </div>