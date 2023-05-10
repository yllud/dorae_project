<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		// FAQ 테스트
		$("#faqBtn").click(function() {
			$.ajax({
				url: "faq",
				data: {
					faq_id: $("#faq_id").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#faqListBtn").click(function() {
			$.ajax({
				url: "faqList",
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#faqSearchBtn").click(function() {
			$.ajax({
				url: "faqBySearch",
				data: {
					search: $("#faqSearch").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#faqCreateBtn").click(function() {
			let thelpCategory = $("#helpCategory").val();
			$.ajax({
				url: "../admin/faqCreate",
				type: "POST",
				data: {
					helpCategory: thelpCategory,
					title: $("#faqTitle").val(),
					content: $("#faqContent").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#faqUpdateBtn").click(function() {
			let thelpCategory = $("#helpCategory").val();
			$.ajax({
				url: "../admin/faqUpdate",
				type: "POST",
				data: {
					helpCategory: thelpCategory,
					title: $("#faqTitle").val(),
					content: $("#faqContent").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		// 공지사항 테스트
		$("#noticeListBtn").click(function() {
			$.ajax({
				url: "noticeList",
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		// 1:1 문의 테스트
		$("#contactListBtn").click(function() {
			$.ajax({
				url: "contactList",
				type: "POST",
				data: {
					member_id: $("#contactMemberId").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#contactCreateBtn").click(function() {
			$.ajax({
				url: "contactCreate",
				type: "POST",
				data: {
					member_id: $("#contactMemberId").val(),
					title: $("#contactTitle").val(),
					content: $("#contactContent").val(),
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		
	})
</script>
</head>
<body>
	<!--  -->
	<h2>FAQ 테스트</h2>
	
	<p>번호 : <input id="faq_id"/></p>
	<p>제목 : <input id="faqTitle"/></p>
	<p>내용 : <input id="faqContent"/></p>
	<p>검색 : <input id="faqSearch"/></p>
	<select id="helpCategory">
		<option value="asdf">문의 유형</option>
	</select>
	
	<button id="faqBtn">FAQ 단건</button>
	<button id="faqListBtn">FAQ 목록</button>
	<button id="faqSearchBtn">FAQ 검색</button>
	<button id="faqCategoryBtn">FAQ 유형 검색</button>
	<button id="faqCreateBtn">FAQ 등록</button>
	<button id="faqUpdateBtn">FAQ 수정</button>
	
	<hr color="red">
	<div id="faqResult"></div>
	<hr color="orange">
	
	<!--  -->
	<h2>공지사항 테스트</h2>
	
	<p>제목 : <input id="noticeTitle"/></p>
	<p>내용 : <input id="noticeContent"/></p>
	<p>태그 : <input id="noticeTag"/></p>
	
	<button id="noticeListBtn">공지사항 목록</button>
	
	<hr color="red">
	<div id="noticeResult"></div>
	<hr color="orange">
	
	<!--  -->
	<h2>1:1 문의 테스트</h2>
	
	<p>회원 : <input id="contactMemberId"/></p>
	<p>제목 : <input id="contactTitle"/></p>
	<p>내용 : <input id="contactContent"/></p>
	<button id="contactCreateBtn">1:1 문의 등록</button>	
	<button id="contactListBtn">1:1 문의 목록</button>
	
	<hr color="red">
	<div id="contactResult"></div>
	<hr color="orange">
	
</body>
</html>