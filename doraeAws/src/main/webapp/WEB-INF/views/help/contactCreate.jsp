<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${!fn:contains(header.referer, 'help')}">
	<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/help.css" />
</c:if>

<div class="input-wrap">
	<label for="contactTitle" class="label">제목</label> 
	<input id="contactTitle" class="input input-contact"/>
</div>
<div class="input-wrap">
	<label for="contactContent" class="label">내용</label>
	<textarea id="contactContent" class="input input-contact textarea-contact"></textarea>	
</div>

<button id="contactCreateBtn" onclick="contactCreate(this)" class="btn btn-gray btn-large">1:1 문의 등록</button>			
<c:if test="${fn:contains(header.referer, 'help')}">
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
</c:if>
<c:if test="${!fn:contains(header.referer, 'help')}">
	<button id="toList" class="btn btn-gray btn-large btn-ajax" data-url="../help/contactList" data-target="#qnaList" value="contactList">목록으로</button>
	<script type="text/javascript">
		function contactCreate(element) {
			$.ajax({
				url: "../help/contactCreate",
				type: "POST",
				data: {
					title: $("#contactTitle").val(),
					content: $("#contactContent").val()
				},
				success: function(res) {
					if (res.success) {
						$("#toList").trigger("click");
					} else {
						alert("문의 등록에 실패했습니다.\n잠시 후 다시 시도해주세요.");
					}
				}
			});
		}
	</script>
</c:if>