<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty contactList }">
<!-- 배열이 비어있으면 -->
<p class="no-result">문의 내역이 없습니다.</p>
</c:if>
<c:if test="${not empty contactList }">
<!-- 배열이 비어있지 않으면 -->
<c:forEach items="${contactList }" var="item">
<li class="list-item">
	<button class="list-item-btn" value="contactOne?contact_id=${item.contact_id }" onclick="goToList(this)">${item.title }</button>
</li>
</c:forEach>
</c:if>

<!-- 1:1 문의 -->
<div id="other">
	<button  class="btn btn-gray btn-large" value="contactCreate" onclick="goToList(this)">문의 작성</button>
</div>