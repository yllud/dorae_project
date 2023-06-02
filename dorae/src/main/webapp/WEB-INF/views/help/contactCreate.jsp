<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="input-wrap">
	<label for="contactTitle" class="label">제목</label> 
	<input id="contactTitle" class="input input-contact"/>
</div>
<div class="input-wrap">
	<label for="contactContent" class="label">내용</label>
	<textarea id="contactContent" class="input input-contact textarea-contact"></textarea>	
</div>

<button id="contactCreateBtn" onclick="contactCreate(this)" class="btn btn-gray btn-large">1:1 문의 등록</button>			
<button class="btn btn-gray btn-large" value="contactList" onclick="goToList(this)">목록으로</button>

<script type="text/javascript">
	function contactCreate(element) {
		$.ajax({
			url: "contactCreate",
			type: "POST",
			data: {
				title: $("#contactTitle").val(),
				content: $("#contactContent").val()
			},
			success: function(res) {
				if (res.success) {
					goToPage("contactList");
				} else {
					alert("문의 등록에 실패했습니다.\n잠시 후 다시 시도해주세요.");
				}
			}
		});
	}
</script>