<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" /> <!-- 구글 폰트/아이콘 -->
<link rel="stylesheet" href="/dorae/resources/css/chatBot.css" />
<script type="text/javascript" src="/dorae/resources/js/jquery-3.6.4.js"></script>
<script defer type="text/javascript" src="/dorae/resources/js/chatBot.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("/dorae/header/header.jsp");
		
		$(".faqItemBtn").click(function() {
				$.ajax({
					url: "faqOne",
					data: {
						faq_id: $(this).val()
					},
					context: this, // ajax에서 현재 객체(.faqItemBtn)를 사용할 수 있다.
					success: function(res) {					
						$(this).closest("li")
							.append($("<div>", {class: "faqItemContent"})
							.html(res.content)); // this 와 가장 가까운 상위 요소(부모) 에 내용 추가					
						$(this).off("click");
						$(this).click(function() {
							$(this).next("div.faqItemContent").toggle();
						})
					}
				})
			})
	})
	
</script>
<style type="text/css">
	#helpBody {
		margin: 0 200px;
		background-color: ivory;
		text-align: center;
		position: relative;
		top: 200px;
	}
	
	#faqTitle {
		display: inline-block;
		border-right: 1px solid;
		padding-right: 10px;
	}

	#search {
		text-align: center;
	}
	
	#searchInput {
		width: 500px;
		font-size: 20px;
		margin-left: 7px;
	}
	
	#searchBtn {
		font-size: 20px;
	}
	
	#search {
		text-align: center;
	}
	
	#searchInput {
		width: 500px;
		font-size: 20px;
		margin-left: 7px;
	}
	
	#searchBtn {
		font-size: 20px;
	}
	
	.btn-large {
		font-size: 26px;
		margin: 10px;
		padding: 10px;
	}
	
	.btn-small {
		font-size: 20px;
		margin: 4px;
	}
	
	#searchList {
		padding: 0 40px;
	}
	
	.faqItem:first-child {
		border-top: 1px solid grey;
	}
	
	.faqItem {
		list-style: none;
		border-bottom: 1px solid grey;
		width: 100%;
		text-align: left;
	}
	
	.faqItemBtn {
		padding: 12px;
		font-size: 24px;
		border: 0;
		background-color: transparent;
		cursor: pointer;
		text-align: left;
	}
	
	.faqItemContent {
		font-size: 20px;
		padding: 12px;
	}
	
	.noResult {
		font-size: 24px;
	}
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	
	<div id="helpBody">
		<!-- FAQ 검색 -->
		<form action="faqSearch">
			<h2 id="faqTitle">FAQ 검색</h2>
			<input type="text" name="page" value="1" hidden="hidden"/>
			<input type="text" id="searchInput" name="search" value="${search }"/>
			<button type="submit" id="searchBtn">검색</button>
		</form>
		
		<!-- FAQ 유형별 버튼 -->
		<div id="faqBtnList">
			<c:forEach items="${helpCategory}" var="item">
			<a href="faqCategory?help_category_id=${item.help_category_id }">
				<button class="btn-small">${item.name }</button>
			</a>
			</c:forEach>
		</div>
		<hr color="red">
		
		<div id="helpContent">
			<c:if test="${empty faqList }">
			<p class="noResult">검색결과가 없습니다.</p>
			</c:if>
			<c:if test="${not empty faqList }">
			<ul id="faqList">
				<c:forEach items="${faqList }" var="item">
				<li class="faqItem">
					<button class="faqItemBtn" value="${item.faq_id }">${item.title }</button>
				</li>
				</c:forEach>
			</ul>
			
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<li class="page-item <c:if test="${page.startPage == 1 }">disabled</c:if>">
					    <a class="page-link" href="/dorae/help/faqSearch?search=${search }&page=${page.startPage - 1 }">&lt;</a>
					</li>
					<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p">
					<li class="page-item">
						<a class="page-link <c:if test="${page.page eq p }">active</c:if>" href="/dorae/help/faqSearch?search=${search }&page=${p }">${p }</a>
					</li>
					</c:forEach>
					<li class="page-item <c:if test="${page.endPage == page.lastPage}">disabled</c:if>">
					    <a class="page-link" href="/dorae/help/faqSearch?search=${search }&page=${page.endPage + 1 }">&gt;</a>
					</li>
				</ul>
			</nav>
			</c:if>
		</div>
	</div>
	
	<!-- 챗봇 -->
	<div id="chatMain" class="chatCommon" hidden="hidden">
		<div id="chatTop">
			<div id="chatTitle">
				<span class="material-symbols-outlined symbol">confirmation_number</span>
				<span style="font-size: 24px;">도래 챗봇</span>
			</div>
			<button class="chatBtn chatMenuBtn" onclick="chatToggle()">
				<span class="material-symbols-outlined symbol">close</span>
			</button>
		</div>
		<div id="chatWrapper">
			<ul id="chatList"></ul>
		</div>
		<div id="chatBottom">
			<button id="home" class="chatBtn chatMenuBtn" onclick="sendMessage(this)" value="홈">
				<span class="material-symbols-outlined symbol">home</span>
			</button>
		</div>
	</div>
	<button id="chatOpenBtn" class="chatBtn chatCommon" onclick="chatToggle()">
		<span class="material-symbols-outlined symbol">contact_support</span>
	</button>
</body>
</html>