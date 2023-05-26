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
	<div class="col-sm-10">
    	<textarea class="form-control" id="noticeContent" rows="5"></textarea>
	</div>
</div>

<div class="mb-3 row">
  <label for="noticeTag" class="col-sm-2 col-form-label">태그</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="noticeTag" />
  </div>
</div>

<button class="btn btn-primary mb-3" onclick="submitFaq(this)">등록</button>

<script type="text/javascript">
	function submitFaq(element) {
		$.ajax({
			url: "/dorae/admin/faq/create",
			type: "POST",
			data: {
				title: $("#noticeTitle").val(),
				content: $("#noticeContent").val(),
				tag: $("#noticeTag").val()
			},
			success: function(res) {
				asyncLoad(history.state.url);
			}
		})
	}
</script>