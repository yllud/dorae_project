<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background: white;
}

td {
	width: 100px;
	text-align: center;
}

.top {
	background: pink;
	color: black;
}

.down {
	background: gray;
	color: white;
}
</style>
<script type="text/javascript">
$(function() {
	//시작하자마자 보여줄 ajax
	$.ajax({
		url : "replyList",
		success : function(x) {
			$('#result').append(x)
		}//success
	})//ajax
})//$
</script>
</head>
<body>
<h2>후기내역</h2>
	${nickname} 님
	<table>
        <tr>
            <th>r_number</th>
            <th>text</th>
            <th>booking</th>
            <th>date</th>
            <th>imp_uid</th>
            <th>email</th>
            <th>upload_date</th>
        </tr>
        <c:forEach items="${list}" var="reply">
            <tr>
                <td>${reply.r_number}</td>
                <td>${reply.text}</td>
                <td>${reply.booking}</td>
                <td>${reply.date}</td>
                <td>${reply.imp_uid}</td>
                <td>${reply.email}</td>
                <td>${reply.upload_date}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>