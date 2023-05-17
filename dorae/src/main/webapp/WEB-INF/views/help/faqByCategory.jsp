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
		$("#header").load("/dorae/header.jsp");
		
		$(".faqItemBtn").click(function() {
			$.ajax({
				url: "faqOne",
				data: {
					faq_id: $(this).val()
				},
				context: this, // ajax에서 현재 객체(.faqItemBtn)를 사용할 수 있다.
				success: function(res) {					
					if ($(this).children().length != 0) { // 자식 노드가 있으면 제거
						$(this).children().remove(); // 자식 노드 삭제
					}
					
					$(this).closest("li")
						.append($("<p>", {class: "faqItemContent"})
						.text(res.content)); // this 와 가장 가까운 상위 요소(부모) 에 내용 추가
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
	
	.searchItemBtn p {
		margin-bottom: 0;
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
		text-align: center;
		padding: 0 10%;
	}
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	
	<div id="helpBody">
		<!-- FAQ 검색 -->
		<form action="faqBySearch">
			<h2 id="faqTitle">FAQ 검색</h2>
			<input type="text" id="searchInput" name="search"/>
			<button type="submit" id="searchBtn">검색</button>
		</form>
		
		<div id="helpContent">
			<!-- FAQ 유형별 버튼 -->
			<div id="faqBtnList">
				<c:forEach items="${helpCategory}" var="item">
				<a href="faqByCategory?help_category_id=${item.help_category_id }">
					<button class="btn-small">${item.name }</button>
				</a>
				</c:forEach>
			</div>
			<hr color="red">
			
			<div id="faqItemList">
				<ul id="faqList">
					<c:forEach items="${faqList }" var="item">
					<li class="faqItem">
						<button class="faqItemBtn" value="${item.faq_id }">${item.title }</button>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		
		<!-- 1:1 문의 -->
		<div id="other">
			<a href="contactList">
				<button class="btn-large">1:1문의</button>
			</a>
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