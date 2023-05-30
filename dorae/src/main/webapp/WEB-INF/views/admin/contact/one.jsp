<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">1:1 문의 답변 페이지</h1>
</div>
<div class="mb-3 row">
	<label for="contactTitle" class="col-sm-2 col-form-label">제목</label>
	<div class="col-sm-10">
	  	<p class="form-control-plaintext" id="contactTitle">${contact.title}</p>
	</div>
</div>
<div class="mb-3 row">
	<label for="contactContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10">
		<p class="form-control-plaintext" id="contactContent">${contact.content}</p>		
	</div>
</div>

<div class="mb-3 row">
	<label for="contactAnswer" class="col-sm-2 col-form-label">답변 내용</label>
	<div class="col-sm-10">
		<c:if test="${not empty contact.answer }">
			<textarea class="form-control" id="contactAnswer" rows="5" readonly>${contact.answer }</textarea>
		</c:if>
		<c:if test="${empty contact.answer }">
			<textarea class="form-control" id="contactAnswer" rows="5"></textarea>
		</c:if>
	</div>
</div>

<c:if test="${empty contact.answer }">
<button class="btn btn-primary mb-3" value="${contact.contact_id }" onclick="submitAnswer(this)">답변 등록</button>

<script type="text/javascript">
	function submitAnswer(element) {
		asyncLoad("/dorae/admin/contact/updateAnswer",
				"POST", {
					contact_id: element.value,
					answer: $("#contactAnswer").val()
				});
	}
</script>
</c:if>

<button class="btn btn-light mb-3" onclick="javascript:history.back()">목록으로</button>