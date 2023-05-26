<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">공지사항 페이지</h1>
</div>
<div class="mb-3 row">
  <label for="noticeTitle" class="col-sm-2 col-form-label">제목</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="noticeTitle" value="${notice.title }">
  </div>
</div>

<div class="mb-3 row">
	<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10">
    	<textarea class="form-control" id="noticeContent" rows="5">${notice.content }</textarea>
	</div>
</div>

<div class="mb-3 row">
  <label for="noticeTag" class="col-sm-2 col-form-label">태그</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="noticeTag" value="${notice.tag }" />
  </div>
</div>

<button class="btn btn-primary mb-3" value="${notice.notice_id }" onclick="submitContent(this)">내용 수정</button>
<button class="btn btn-light mb-3" onclick="javascript:history.back()">목록으로</button>

<script type="text/javascript">
	function submitContent(element) {
		$.ajax({
			url: "/dorae/admin/notice/update",
			type: "POST",
			data: {
				notice_id: element.value,
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
