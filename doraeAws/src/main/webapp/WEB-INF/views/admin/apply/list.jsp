<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">사업자 신청 목록 페이지</h1>
</div>
<div class="table-responsive">
	<table class="table table-striped table-hover aling-middle">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">신청자</th>
				<th scope="col">신청일</th>
				<th scope="col">승인/거부</th>
				<th scope="col">승인/거부일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${applyList }" var="item">
				<tr>
					<td>${item.apply_id }</td>
					<td>${item.member_id }</td>
 					<td><fmt:timeZone value="GMT">
					<fmt:formatDate value="${item.created_at }" pattern="yyyy-MM-dd hh:mm:ss"/>
					</fmt:timeZone></td>
					<c:if test="${empty item.approval_at }">
					<td>검토 중</td>
					<td></td>
					</c:if>
					<c:if test="${not empty item.approval_at }">
						<c:if test="${item.approval == true }">
						<td>승인</td>
						</c:if>
						<c:if test="${item.approval == false }">
						<td>거부</td>						
						</c:if>
						<td><fmt:timeZone value="GMT">
						<fmt:formatDate value="${item.approval_at }" pattern="yyyy-MM-dd hh:mm:ss"/>
						</fmt:timeZone></td>
					</c:if>
					<td><button class="btn btn-link" value="admin/apply/one?page=${param.page }&apply_id=${item.apply_id }" onclick="goToList(this)">보기</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 하단 페이지 버튼 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <li class="page-item <c:if test="${page.startPage == 1 }">disabled</c:if>">
	      <button class="page-link" value="admin/apply/list?page=${page.startPage - 1 }" onclick="goToList(this)">&lt;</button>
	    </li>
	    <c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
			<li class="page-item">
				<button class="page-link <c:if test="${page.page eq p }">active</c:if>" value="admin/apply/list?page=${p }" onclick="goToList(this)">${p }</button>
			</li>
		</c:forEach>
	    <li class="page-item <c:if test="${page.endPage == page.lastPage}">disabled</c:if>">
	      <button class="page-link" value="admin/apply/list?page=${page.endPage + 1 }" onclick="goToList(this)">&gt;</button>
	    </li>
	  </ul>
	</nav>

</div>