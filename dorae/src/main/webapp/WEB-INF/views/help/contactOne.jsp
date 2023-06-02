<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table class="table-center">
	<tr>
		<td class="row-border"><label for="contactTitle" class="label">제목</label></td>
		<td class="row-border"><p id="contactTitle">${vo.title }</p></td>
	</tr>
	<tr>
		<td class="row-border"><label for="contactContent" class="label">내용</label></td>
		<td class="row-border"><p id="contactContent">${vo.content }</p></td>
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
<button class="btn btn-gray btn-large" value="contactList" onclick="goToList(this)">목록으로</button>