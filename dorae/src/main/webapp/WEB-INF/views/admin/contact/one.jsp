<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">1:1 문의 답변 페이지</h1>
</div>
<div class="mb-3 row border-bottom">
	<label for="staticTitle" class="col-sm-2 col-form-label">제목</label>
	<div class="col-sm-10">
	  <input type="text" readonly class="form-control-plaintext" id="staticTitle" value="${contact.title}">
	</div>
</div>
<div class="mb-3 row border-bottom">
	<label for="staticContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10">
	  <input type="text" readonly class="form-control-plaintext" id="staticContent" value="${contact.content}">
	</div>
</div>

<div class="mb-3">
	<label for="answerTextarea" class="form-label">답변 내용</label>
	<c:if test="${not empty contact.answer }">
		<textarea class="form-control" id="answerTextarea" rows="5" readonly>${contact.answer }</textarea>
	</c:if>
	<c:if test="${empty contact.answer }">
		<textarea class="form-control" id="answerTextarea" rows="5"></textarea>
	</c:if>
</div>

<c:if test="${empty contact.answer }">
<button class="btn btn-primary mb-3" value="${contact.contact_id }" onclick="submitAnswer(this)">답변 등록</button>
<script type="text/javascript">
	function submitAnswer(element) {
		$.ajax({
			url: "/dorae/admin/contact/updateAnswer",
			type: "POST",
			data: {
				contact_id: element.value,
				answer: $("#answerTextarea").val()
			},
			success: function(res) {
				asyncLoad(history.state.url);
			}
		})
	}
</script>
</c:if>

<%-- <div>
	<form action="updateAnswer" method="post">
		<input value="${contact.contact_id}" name="contact_id" hidden="hidden">
		<p>제목 : <span>${contact.title }</span></p>
		<p>내용 : <span>${contact.content }</span></p>
		<hr color="red">
		<c:if test="${empty contact.answer }">
			<p>
				답변 : <textarea rows="20" cols="30" name="answer"></textarea>
			</p>
			<button type="submit">답변 등록</button>
		</c:if>
		<c:if test="${not empty contact.answer }">
			<p>답변 : <span>${contact.answer }</span></p>
		</c:if>
	</form>
</div> --%>