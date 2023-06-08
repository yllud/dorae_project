<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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