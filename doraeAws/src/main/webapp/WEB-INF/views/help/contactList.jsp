<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${!fn:contains(header.referer, 'help')}">
	<link rel="stylesheet" href="../resources/css/help.css" />
</c:if>

<c:if test="${empty contactList }">
<!-- 배열이 비어있으면 -->
<p class="no-result">문의 내역이 없습니다.</p>
</c:if>

<c:if test="${not empty contactList }">
<!-- 배열이 비어있지 않으면 -->
<c:forEach items="${contactList }" var="item">
<li class="list-item">
	<c:if test="${fn:contains(header.referer, 'help')}">
		<button class="list-item-btn" value="contactOne?contact_id=${item.contact_id }" onclick="goToList(this)">${item.title }</button>
	</c:if>
	<c:if test="${!fn:contains(header.referer, 'help')}">
		<button class="list-item-btn btn-ajax" data-url="../help/contactOne?contact_id=${item.contact_id }" data-target="#qnaList">${item.title }</button>
	</c:if>
</li>
</c:forEach>

</c:if>
<c:if test="${fn:contains(header.referer, 'help')}">
	<button class="btn btn-gray btn-large" value="contactCreate" onclick="goToList(this)">문의 작성</button>
</c:if>
<c:if test="${!fn:contains(header.referer, 'help')}">
	<button class="btn btn-gray btn-large btn-ajax" data-url="../help/contactCreate" data-target="#qnaList">문의 작성</button>
</c:if>