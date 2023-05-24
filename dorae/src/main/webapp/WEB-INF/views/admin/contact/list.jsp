<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="table-responsive">
	<table class="table table-striped table-hover aling-middle">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">제목</th>
				<th scope="col">등록일</th>
				<th scope="col">답변 여부</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${contactList }" var="item">
				<tr>
					<td>${item.contact_id }</td>
					<td><button class="btn btn-link" value="/dorae/admin/contact/one?contact_id=${item.contact_id }" onclick="goToPage(this)">${item.title }</button></td>
					<td>${item.created_at }</td>
					<c:if test="${empty item.admin_id }">
						<td>미완료</td>
					</c:if>
					<c:if test="${not empty item.admin_id }">
						<td>완료</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 하단 페이지 버튼 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <li class="page-item <c:if test="${page.startPage == 1 }">disabled</c:if>">
	      <button class="page-link" value="/dorae/admin/contact/list?page=${page.startPage - 1 }" onclick="goToPage(this)">&lt;</button>
	    </li>
	    <c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
			<li class="page-item">
				<button class="page-link <c:if test="${page.page eq p }">active</c:if>" value="/dorae/admin/contact/list?page=${p }" onclick="goToPage(this)">${p }</button>
			</li>
		</c:forEach>
	    <li class="page-item <c:if test="${page.endPage == page.lastPage}">disabled</c:if>">
	      <button class="page-link" value="/dorae/admin/contact/list?page=${page.endPage + 1 }" onclick="goToPage(this)">&gt;</button>
	    </li>
	  </ul>
	</nav>

</div>