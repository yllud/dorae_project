<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">공지사항 페이지</h1>
</div>
<div class="mb-3 row">
  <label for="noticeTitle" class="col-sm-2 col-form-label">제목</label>
  <div class="col-sm-10">
    <p class="form-control-plaintext" id="noticeTitle">${notice.title }</p>
  </div>
</div>

<div class="mb-3 row">
	<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10 py-2">${notice.content }</div>
</div>

<div class="mb-3 row">
  <label for="noticeTag" class="col-sm-2 col-form-label">태그</label>
  <div class="col-sm-10">
    <p class="form-control-plaintext" id="noticeTag">${notice.tag }</p>
  </div>
</div>

<button class="btn btn-primary mb-3" value="/dorae/admin/notice/update?page=${param.page }&notice_id=${notice.notice_id }" onclick="goToList(this, true)">내용 수정</button>
<button class="btn btn-light mb-3" value="/dorae/admin/notice/list?page=${param.page }" onclick="goToList(this)" id="toList">목록으로</button>
<button class="btn btn-danger mb-3" onclick="deleteNotice()">삭제</button>

<script type="text/javascript">
	function deleteNotice() {
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				url: "/dorae/admin/notice/delete",
				type: "POST",
				data: {
					notice_id: ${notice.notice_id}
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