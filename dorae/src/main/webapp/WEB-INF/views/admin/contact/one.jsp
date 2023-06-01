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
			<p class="form-control-plaintext" id="contactAnswer">${contact.answer }</p>
		</c:if>
		<c:if test="${empty contact.answer }">
			<textarea class="form-control" id="contactAnswer" rows="5"></textarea>
		</c:if>
	</div>
</div>

<c:if test="${empty contact.answer }">
<button class="btn btn-primary mb-3" onclick="submitAnswer(this)">답변 등록</button>
</c:if>

<button class="btn btn-light mb-3" value="/dorae/admin/contact/list?page=${param.page }" onclick="goToList(this)" id="toList">목록으로</button>
<button class="btn btn-danger mb-3" onclick="deleteContact()">삭제</button>

<script type="text/javascript">
	function deleteContact() {
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				url: "/dorae/admin/contact/delete",
				type: "POST",
				data: {
					contact_id: ${contact.contact_id}
				},
				success: function(res) {
					if (res.success) {
						goToList($("#toList")[0], true);
					}
				}
			})			
		}
	}
</script>
<c:if test="${empty contact.answer }">
<script type="text/javascript">
	function submitAnswer(element) {
		$.ajax({
			url: "/dorae/admin/contact/updateAnswer",
			type: "POST",
			data: {
				contact_id: ${contact.contact_id },
				answer: $("#contactAnswer").val()
			},
			success: function(res) {
				if (res.success) {
					goToPage("/dorae/admin/contact/one?page=" + ${param.page } + "&contact_id=" + ${contact.contact_id}, true);
				}
			}
		})
	}
</script>
</c:if>