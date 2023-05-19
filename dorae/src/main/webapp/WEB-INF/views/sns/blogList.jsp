<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="item" items="${list}">
	<div
		style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">
		<h3>${item.title}</h3>
		<p>${item.description}</p>
		<a href="${item.link}" target="_blank">${item.link}</a>
	</div>
</c:forEach>