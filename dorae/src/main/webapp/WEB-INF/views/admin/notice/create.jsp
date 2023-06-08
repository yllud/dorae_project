<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">공지사항 등록 페이지</h1>
</div>

<div class="mb-3 row">
  <label for="noticeTitle" class="col-sm-2 col-form-label">제목</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="noticeTitle">
  </div>
</div>

<div class="mb-3 row">
	<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10" style="height: 500px;">
		<iframe src="resources/smarteditor2-2.8.2.3/SmartEditor2.html" width="100%" height="100%" id="noticeContent"></iframe>
	</div>
</div>

<div class="mb-3 row">
  <label for="noticeTag" class="col-sm-2 col-form-label">태그</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="noticeTag" />
  </div>
</div>

<button class="btn btn-primary mb-3" onclick="submitNotice(this)">등록</button>

<script type="text/javascript">
	function submitNotice(element) {
		$("#noticeContent").get(0).contentWindow.submitContents();	// 에디터의 내용이 textarea에 적용됩니다. // 에디터가 iframe 내에 있어서 contentWindow 를 가져와서 함수 호출
		
		$.ajax({
			url: "admin/notice/create",
			type: "POST",
			data: {
				title: $("#noticeTitle").val(),
				content: $("#noticeContent").contents().find("#ir1").val(),
				tag: $("#noticeTag").val()
			},
			success: function(res) {
				if (res.success) {
					goToPage("admin/notice/one?page=1&notice_id=" + res.message);
				}
			}
		});
	}
	
	function setContent() {
		$("#noticeContent")[0].contentWindow.clearHTML();
	}
</script>