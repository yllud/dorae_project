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
	})
</script>
<style type="text/css">
	.content-body {
		margin: 0 300px;
		text-align: center;
		position: relative;
		top: 200px;
	}
	
	.title-faq {
		display: inline-block;
		border-right: 1px solid;
		padding-right: 10px;
	}

	.search-area {
		display: inline-flex;
	}
	
	.input {
		width: 500px;
		font-size: 20px;
		margin-left: 7px;
		outline: none;
		padding: 5px 10px;	
	}
	
	.input-search {
		border: 2px solid orange;
		border-radius: 10px 0 0 10px;
	}
	
	.input-contact {
		border-radius: 8px;
		border: 1px solid black;
	}
	
	.textarea-contact {
		height: 300px;
		resize: none;
	}
	
	.btn-search {
		font-size: 20px;
		border: 0;
		border-radius: 0 10px 10px 0;
		padding: 10px;
		background-color: orange;
		color: white;
		font-weight: bold;
		cursor: pointer;
	}
	
	.btn {
		cursor: pointer;
	}
	
	.btn:hover {
		transition: .2s;
		background-color: orange;
		color: white;
	}
	
	.btn-gray {
		border: 1px solid gray;
		border-radius: 20px;
		background: ghostwhite;
	}
	
	.btn-large {
		font-size: 26px;
		margin: 10px;
		padding: 10px;
	}
	
	.btn-small {
		font-size: 20px;
		margin: 4px;
		padding: 5px 10px;
	}
	
	.btn-page {
		font-size: 20px;
		margin: 5px;
		padding: 5px 10px;
		background-color: transparent;
		border: 0;
		color: black;
		border-radius: 8px;
	}
	
	.btn-active {
		background-color: orange;
		color: white;
	}
	
	.list {
		padding: 0;
	}
	
	.list-item:first-child {
		border-top: 1px solid grey;
	}
	
	.list-item {
		list-style: none;
		border-bottom: 1px solid grey;
		text-align: left;
		width: 100%;
	}
	
	.list-item-btn {
		padding: 12px;
		font-size: 24px;
		border: 0;
		background-color: transparent;
		cursor: pointer;
		text-align: left;
	}

	.list-item-content {
		font-size: 20px;
		padding: 12px;
	}
	
	.no-result {
		font-size: 24px;
	}
	
	.label {
		margin: auto 30px auto 0;
	}
	
	.input-wrap {
		display: flex;
		justify-content: center;
		min-width: 500px;
		margin: 10px;
	}
	
	.pagination {
		background-color: transparent;
	}
	
	.table-center {
		margin: auto;
		border-collapse: collapse;
	}
	
	.table-center * {
		font-size: 20px;
	}
	
	.row-border {
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		padding: 0;
	}
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	
	<div class="content-body">
		<!-- 페이지가 삽입될 곳 -->
		<div id="helpContent">
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
	<script type="text/javascript">		
		function faqSearch(element) {
			let url = element.value + $("#searchInput").val();
			goToPage(url);
		}
		
		function goToList(element, isReplace) {
			goToPage(element.getAttribute("value"), isReplace);
		}
		
		function goToPage(url, isReplace) {
			if (isReplace) {
				history.replaceState({"url": url}, null, location.pathname);
			} else {
				history.pushState({"url": url}, null, location.pathname);				
			}
			asyncLoad(url);
		}
		
		function asyncLoad(url, type, data) {
			$.ajax({
				url: url,
				type: type,
				data: data,
				success: function(res, statusText, jqXHR) {
					$("#helpContent").html(res);
				}
			})			
		}
		
		window.onpopstate = function(event) {
			if (event.state != null) { // state 가 null 이 아닐 때만 ajax로 갱신
				asyncLoad(event.state.url);				
			}
		}
		
		goToPage("mainContent");
	</script>
</body>
</html>