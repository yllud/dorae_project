<!-- test.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 지도와 목록 탭</title>
<style>
table {
border:1px solid #444444;
width: 90%;
margin: 10px;
padding: 10px;
}
</style>
</head>
<body>
	<c:forEach var="i" begin="0" end="5">
		<table>
			<tr>
				<td>포스터</td>
			</tr>
			<tr>
				<td>공연 + ${i}</td>
			</tr>
			<tr>
				<td>공연장</td>
			</tr>
			<tr>
				<td>주소</td>
			</tr>
		</table>
	</c:forEach>

	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>

</body>