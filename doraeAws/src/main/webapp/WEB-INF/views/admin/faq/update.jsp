<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">FAQ 수정 페이지</h1>
</div>

<div class="mb-3 row">
  <label for="faqTitle" class="col-sm-2 col-form-label">제목</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="faqTitle">
  </div>
</div>

<div class="mb-3 row">
	<label for="faqContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10" style="height: 500px;">
		<iframe src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/smarteditor2-2.8.2.3/SmartEditor2.jsp" width="100%" height="100%" id="faqContent"></iframe>
	</div>
</div>

<div class="mb-3 row">
  <label for="faqCategory" class="col-sm-2 col-form-label">유형</label>
  <div class="col-sm-10">
	  <select class="form-select" id="faqCategory">
	    <c:forEach items="${helpCategoryList }" var="item">
	    <option value="${item.help_category_id }">${item.name }</option>
	    </c:forEach>
	  </select>
  </div>
</div>

<button class="btn btn-primary mb-3" onclick="submitFaq(this)">등록</button>
<button class="btn btn-light mb-3" value="admin/faq/one?page=${param.page }&faq_id=${faq_id}" onclick="goToList(this)">뒤로</button>

<script type="text/javascript">
	function submitFaq(element) {
		$("#faqContent").get(0).contentWindow.submitContents();	// 에디터의 내용이 textarea에 적용됩니다. // 에디터가 iframe 내에 있어서 contentWindow 를 가져와서 함수 호출
		
		$.ajax({
			url: "admin/faq/update",
			type: "POST",
			data: {
				faq_id: ${faq_id},
				help_category_id: $("#faqCategory").val(),
				title: $("#faqTitle").val(),
				content: $("#faqContent").contents().find("#ir1").val(),
			},
			success: function(res) {
				if (res.success) {
					goToPage("admin/faq/one?page=" + ${param.page } + "&faq_id=" + ${faq_id}, true);
				}
			}
		});
	}
	
	function setContent() {
		$.ajax({
			url: "admin/faq/one.json",
			data: {
				faq_id: ${faq_id}
			},
			success: function(res) {
				$("#faqTitle").val(res.title);
				$("#faqCategory").val(res.help_category_id).prop("selected", true);
				$("#faqContent")[0].contentWindow.pasteHTML(res.content);
			}
		})
	}
</script>