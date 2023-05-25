<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">FAQ 페이지</h1>
</div>
<div class="mb-3 row">
	<label for="faqTitle" class="col-sm-2 col-form-label">제목</label>
	<div class="col-sm-10">
	  <input type="text" readonly class="form-control" id="faqTitle" value="${faq.title}">
	</div>
</div>

<div class="mb-3 row">
	<label for="faqCategory" class="col-sm-2 col-form-label">유형</label>
	<div class="col-sm-10">
	  <input type="text" readonly class="form-control" id="faqCategory" value="${faq.help_category_id}">
	</div>
</div>

<div class="mb-3 row">
	<label for="faqContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10">
		<textarea class="form-control" id="faqContent" rows="5" readonly>${faq.content }</textarea>
	</div>
</div>

<button class="btn btn-primary mb-3" value="${faq.faq_id }" onclick="submitContent(this)">내용 수정</button>
<button class="btn btn-light mb-3" onclick="javascript:history.back()">목록으로</button>

<script type="text/javascript">
	function submitContent(element) {
		$.ajax({
			url: "/dorae/admin/faq/updateContent",
			type: "POST",
			data: {
				faq_id: element.value,
				answer: $("#faqContent").val()
			},
			success: function(res) {
				asyncLoad(history.state.url);
			}
		})
	}
</script>
