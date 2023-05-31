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
                <td>${review.review_id}</td>
                <td><a href="../review/detail?id=${review.review_id}">${review.review_title}</a></td>
                <td>${review.review_content}</td>
            </tr>
        </c:forEach>
    </table>
    </div>