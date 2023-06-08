<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">사업자 신청 페이지</h1>
</div>
<div class="mb-3 row">
	<label for="applyMemberId" class="col-sm-2 col-form-label">신청자</label>
	<div class="col-sm-10">
	  <p class="form-control-plaintext" id="applyMemberId">${apply.member_id}</p>
	</div>
</div>
<div class="mb-3 row">
	<label for="applyCreatedAt" class="col-sm-2 col-form-label">신청일</label>
	<div class="col-sm-10">
	  <p class="form-control-plaintext" id="applyCreatedAt">
	  	<fmt:timeZone value="GMT"><fmt:formatDate value="${apply.created_at }" pattern="yyyy-MM-dd hh:mm:ss"/></fmt:timeZone>
	  </p>
	</div>
</div>

<div class="mb-3 row">
	<label for="applyApproval" class="col-sm-2 col-form-label">승인/거부</label>
	<div class="col-sm-10">
		<c:if test="${empty apply.approval_at }">
		<button class="btn btn-success mb-3" value="true" onclick="submitApproval(this)">승인</button>
		<button class="btn btn-danger mb-3" value="false" onclick="submitApproval(this)">거부</button>
		</c:if>
		
		<c:if test="${not empty apply.approval_at }">
			<c:if test="${apply.approval == true }"> 
			<input type="text" readonly class="form-control-plaintext" id="applyApproval" value="승인">
			</c:if>
			<c:if test="${apply.approval == false }">
			<input type="text" readonly class="form-control-plaintext" id="applyApproval" value="거부">						
			</c:if>
			<td></td>
		</c:if>
	</div>
</div>

<div class="mb-3 row">
	<label for="applyApproval_at" class="col-sm-2 col-form-label">승인/거부일</label>
	<div class="col-sm-10">
		<p class="form-control-plaintext" id="applyApproval_at"> 
		  	<fmt:timeZone value="GMT"><fmt:formatDate value="${apply.approval_at }" pattern="yyyy-MM-dd hh:mm:ss"/></fmt:timeZone>
		</p>
	</div>
</div>

<button class="btn btn-light mb-3" value="admin/apply/list?page=${param.page }" onclick="goToList(this)" id="toList">목록으로</button>

<c:if test="${empty apply.approval_at }">
<script type="text/javascript">
	function submitApproval(element) {
		let confirmStr;
		if (element.value) {
			confirmStr = "정말 승인하시겠습니까?";
		} else {
			confirmStr = "정말 거부하시겠습니까?";
		}
		
		if (confirm(confirmStr)) {
			$.ajax({
				url: "admin/apply/update",
				type: "POST",
				data: {
					apply_id: ${apply.apply_id},
					approval: element.value
				},
				success: function(res) {
					if (res.success) {
						goToPage("admin/apply/one?page=" + ${param.page } + "&apply_id=" + ${apply.apply_id }, true);
					}
				}
			})	
		}
	}
</script>
</c:if>