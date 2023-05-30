<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">FAQ 페이지</h1>
</div>
<div class="mb-3 row">
	<label for="faqTitle" class="col-sm-2 col-form-label">제목</label>
	<div class="col-sm-10">
	  	<p class="form-control-plaintext" id="faqTitle">${faq.title}</p>	
	</div>
</div>

<div class="mb-3 row">
	<label for="faqCategory" class="col-sm-2 col-form-label">유형</label>
	<div class="col-sm-10">
		<c:forEach items="${helpCategoryList }" var="item">
		<c:if test="${item.help_category_id eq faq.help_category_id }">
		<p class="form-control-plaintext" id="faqCategory">${item.name }</p>
		</c:if>
		</c:forEach>
	</div>
</div>

<div class="mb-3 row">
	<label for="faqContent" class="col-sm-2 col-form-label">내용</label>
	<div class="col-sm-10 py-2">${faq.content }</div>
</div>

<button class="btn btn-primary mb-3" value="/dorae/admin/faq/update?faq_id=${faq.faq_id }" onclick="goToPage(this)">내용 수정</button>
<button class="btn btn-light mb-3" onclick="javascript:history.back()">목록으로</button>