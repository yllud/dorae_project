<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" /> <!-- 구글 폰트/아이콘 -->
<link rel="stylesheet" href="../resources/css/chatBot.css" />
<link rel="stylesheet" href="../resources/css/help.css" />
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script defer type="text/javascript" src="../resources/js/chatBot.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
	})
</script>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	
	<div class="content-body">
		<!-- 페이지가 삽입될 곳 -->
		<div id="helpContent">
		</div>
	</div>
	
	<footer></footer>
	
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