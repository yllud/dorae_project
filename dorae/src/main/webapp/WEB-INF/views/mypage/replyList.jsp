<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	background: lime;
}
</style>
</head>
<body>
<h2>후기내역</h2>
	${nickname} 님
	<table>
		<tr>
			<td class="top">r_number</td>
			<td class="top">text</td>
			<td class="top">booking</td>
			<td class="top">date</td>
			<td class="top">imp_uid</td>
			<td class="top">upload_date</td>
		</tr>

		<c:forEach items="${list}" var="bag">
			<tr>
				<td class="down">${bag.r_number}</td>
				<td class="down">${bag.text}</td>
				<td class="down">${bag.booking}</td>
				<td class="down">${bag.date}</td>
				<td class="down">${bag.imp_uid}</td>
				<td class="down">${bag.upload_date}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>