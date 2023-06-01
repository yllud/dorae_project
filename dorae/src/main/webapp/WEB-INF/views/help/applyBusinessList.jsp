<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty applyList }">
<!-- 배열이 비어있으면 -->
<p class="no-result">신청 내역이 없습니다.</p>
</c:if>
<c:if test="${not empty applyList }">
<!-- 배열이 비어있지 않으면 -->
<c:forEach items="${applyList }" var="item">
<li class="list-item">
	<button class="list-item-btn"><fmt:formatDate value="${item.created_at }" pattern="yyyy-MM-dd hh:mm:ss"/></button>
	<c:if test="${empty item.approval_at }">
	<button class="list-item-btn">검토 중</button>
	</c:if>
	<c:if test="${not empty item.approval_at and item.approval == true}">
	<button class="list-item-btn">승인</button>
	</c:if>
	<c:if test="${not empty item.approval_at and item.approval == false}">
	<button class="list-item-btn">거부</button>
	</c:if>
</li>
</c:forEach>
</c:if>

<!-- 사업자 신청 -->
<div id="other">
	<button id="applyBusiness" class="btn btn-gray btn-large">사업자 신청</button>
</div>

<script type="text/javascript">
	$("#applyBusiness").click(function() {
		if (confirm("사업자 신청을 하시겠습니까?")) {
			$.ajax({
				url: "applyBusiness",
				success: function(res) {
					console.log(res);
					if (res.success) {
						alert("신청에 성공하였습니다.");
						asyncLoad("/dorae/help/applyBusinessList");
					} else {
						alert("신청에 실패하였습니다.\n잠시 후 다시 시도해주세요.");
					}
				}
			})		
		}
	})
</script>