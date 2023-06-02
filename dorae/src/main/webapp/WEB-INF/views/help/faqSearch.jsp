<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- FAQ 검색 -->
<div>
	<h2 class="title-faq">FAQ 검색</h2>
	<div class="search-area">
		<input type="text" id="searchInput" class="input input-search" value="${param.search }"/>
		<button value="faqSearch?page=1&search=" class="btn-search" onclick="faqSearch(this)">검색</button>
	</div>
</div>

<!-- FAQ 유형별 버튼 -->
<div id="faqBtnList">
	<c:forEach items="${helpCategory}" var="item">
		<button value="faqCategory?help_category_id=${item.help_category_id }" class="btn btn-gray btn-small" onclick="goToList(this)">${item.name }</button>
	</c:forEach>
</div>
<hr color="red">

<c:if test="${empty faqList }">
<p class="no-result">검색결과가 없습니다.</p>
</c:if>
<c:if test="${not empty faqList }">
<ul class="list">
	<c:forEach items="${faqList }" var="item">
	<li class="list-item">
		<button class="list-item-btn" value="${item.faq_id }">${item.title }</button>
	</li>
	</c:forEach>
</ul>

<nav aria-label="Page-navigation">
	<ul class="pagination">
		<li class="page-item">
		    <button class="btn btn-page" value="/dorae/help/faqSearch?search=${param.search }&page=${page.startPage - 1 }" onclick="goToList(this)" <c:if test="${page.startPage == 1 }">disabled</c:if>>&lt;</button>
		</li>
		<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
		<li class="page-item">
			<button class="btn btn-page <c:if test="${page.page eq p }">btn-active</c:if>" value="/dorae/help/faqSearch?search=${param.search }&page=${p }" onclick="goToList(this)">${p }</button>
		</li>
		</c:forEach>
		<li class="page-item">
		    <button class="btn btn-page" value="/dorae/help/faqSearch?search=${param.search }&page=${page.endPage + 1 }" onclick="goToList(this)" <c:if test="${page.endPage == page.lastPage}">disabled</c:if>>&gt;</button>
		</li>
	</ul>
</nav>
</c:if>

<script type="text/javascript">
	$(function() {		
		$(".list-item-btn").click(function() {
				$.ajax({
					url: "faqOne",
					data: {
						faq_id: $(this).val()
					},
					context: this, // ajax에서 현재 객체(.faqItemBtn)를 사용할 수 있다.
					success: function(res) {					
						$(this).closest("li")
							.append($("<div>", {class: "list-item-content"})
							.html(res.content)); // this 와 가장 가까운 상위 요소(부모) 에 내용 추가					
						$(this).off("click");
						$(this).click(function() {
							$(this).next("div.list-item-content").toggle();
						})
					}
				})
			})
	})
</script>