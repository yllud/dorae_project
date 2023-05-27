<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 신청 내역 - 고객센터</title>
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
	#helpBody {
		margin: 0 200px;
		background-color: ivory;
		text-align: center;
		position: relative;
		top: 200px;
	}
	
	.btn-large {
		font-size: 26px;
		margin: 10px;
		padding: 10px;
	}
	
	.btn-small {
		margin: 4px;
	}
	
	.applyItem:first-child {
		border-top: 1px solid grey;
	}
	
	.applyItem {
		list-style: none;
		border-bottom: 1px solid grey;
		width: 100%;
		text-align: left;
	}
	
	.applyItem a {
		padding: 0;
	}
	
	.applyItemBtn {
		padding: 12px;
		font-size: 24px;
		border: 0;
		background-color: transparent;
		cursor: pointer;
		text-align: left;
	}
</style>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	
	<div id="helpBody">
		<c:if test="${empty applyList }">
		<!-- 배열이 비어있으면 -->
		<p>신청 내역이 없습니다.</p>
		</c:if>
		<c:if test="${not empty applyList }">
		<!-- 배열이 비어있지 않으면 -->
		<c:forEach items="${applyList }" var="item">
		<li class="applyItem">
			<button class="applyItemBtn"><fmt:formatDate value="${item.created_at }" pattern="yyyy-MM-dd hh:mm:ss"/></button>
			<c:if test="${empty item.approval_at }">
			<button class="applyItemBtn">검토 중</button>
			</c:if>
			<c:if test="${not empty item.approval_at and item.approval == true}">
			<button class="applyItemBtn">승인</button>
			</c:if>
			<c:if test="${not empty item.approval_at and item.approval == false}">
			<button class="applyItemBtn">거부</button>
			</c:if>
		</li>
		</c:forEach>
		</c:if>
		
		<!-- 사업자 신청 -->
		<div id="other">
			<button id="applyBusiness" class="btn-large">사업자 신청</button>
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
		$("#applyBusiness").click(function() {
			if (confirm("사업자 신청을 하시겠습니까?")) {
				$.ajax({
					url: "applyBusiness",
					success: function(res) {
						console.log(res);
						if (res.success) {
							alert("신청에 성공하였습니다.");
							location.href = "applyBusinessList";
						} else {
							alert("신청에 실패하였습니다.\n잠시 후 다시 시도해주세요.");
						}
					}
				})		
			}
		})
	</script>
</body>
</html>