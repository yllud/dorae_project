<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">FAQ 목록 페이지</h1>
</div>
<div class="table-responsive">
	<table class="table table-striped table-hover aling-middle">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">제목</th>
				<th scope="col">유형</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${faqList }" var="item">
				<tr>
					<td>${item.faq_id }</td>
					<td><button class="btn btn-link" value="admin/faq/one?page=${param.page }&faq_id=${item.faq_id }" onclick="goToList(this)">${item.title }</button></td>
					<td>${item.help_category_id }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 하단 페이지 버튼 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <li class="page-item <c:if test="${page.startPage == 1 }">disabled</c:if>">
	      <button class="page-link" value="admin/faq/list?page=${page.startPage - 1 }" onclick="goToList(this)">&lt;</button>
	    </li>
	    <c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
			<li class="page-item">
				<button class="page-link <c:if test="${page.page eq p }">active</c:if>" value="admin/faq/list?page=${p }" onclick="goToList(this)">${p }</button>
			</li>
		</c:forEach>
	    <li class="page-item <c:if test="${page.endPage == page.lastPage}">disabled</c:if>">
	      <button class="page-link" value="admin/faq/list?page=${page.endPage + 1 }" onclick="goToList(this)">&gt;</button>
	    </li>
	  </ul>
	</nav>

</div>