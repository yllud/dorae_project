<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- FAQ 검색 -->
<div>
	<h2 class="title-faq">FAQ 검색</h2>
	<div class="search-area">
		<input type="text" id="searchInput" class="input input-search"/>
		<button value="faqSearch?page=1&search=" class="btn-search" onclick="faqSearch(this)">검색</button>
	</div>
</div>

<!-- FAQ 유형별 버튼 -->
<div id="faqBtnList">
	<c:forEach items="${helpCategory}" var="item">
		<button value="faqCategory?help_category_id=${item.help_category_id }" class="btn btn-gray btn-large" onclick="goToList(this)">${item.name }</button>
	</c:forEach>
</div>
<hr color="red">

<!-- 1:1 문의, 사업자 신청 -->
<div id="other">
	<button value="contactList?page=1" class="btn btn-gray btn-large" onclick="goToList(this)">1:1문의</button>
	<button value="applyBusinessList" class="btn btn-gray btn-large" onclick="goToList(this)">사업자 신청</button>
</div>