<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${list}" var="bag">
	<!-- el 속성만 받아올 수 있는 표현식 -->
	<img src="${bag.poster}" width="200" height="200">
	<br>
		제목 : <a href="playDetail?play_id=${bag.play_id}">${bag.play_name}</a>
	<br>
		장르: ${bag.genre_name}<br>
		출연진: ${bag.casting}<br>
		기간: ${bag.play_start} ~ ${bag.play_end}<br>
		공연 상태: ${bag.state}<br>

</c:forEach>