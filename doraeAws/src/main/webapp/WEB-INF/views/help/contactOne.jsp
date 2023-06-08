<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${!fn:contains(header.referer, 'help')}">
	<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/help.css" />
</c:if>
<table class="table-center">
	<tr>
		<td class="row-border"><label for="contactTitle" class="label">제목</label></td>
		<td class="row-border row-content"><p id="contactTitle">${vo.title }</p></td>
	</tr>
	<tr>
		<td class="row-border"><label for="contactContent" class="label">내용</label></td>
		<td class="row-border row-content"><p id="contactContent">${vo.content }</p></td>
	</tr>
	<tr>
		<td class="row-border" colspan="2">
			<c:if test="${empty vo.answer }">
				<p class="no-result">답변이 없습니다.</p>
			</c:if>
			<c:if test="${not empty vo.answer }">
				<p>답변 : <span>${vo.answer }</span></p>
			</c:if>			
		</td>
	</tr>
</table>
<c:if test="${fn:contains(header.referer, 'help')}">
	<button class="btn btn-gray btn-large" value="contactList" onclick="goToList(this)">목록으로</button>
</c:if>
<c:if test="${!fn:contains(header.referer, 'help')}">
	<button class="btn btn-gray btn-large btn-ajax" data-url="../help/contactList" data-target="#qnaList">목록으로</button>
</c:if>