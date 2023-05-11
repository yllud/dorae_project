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
		$.ajax({
			url: "helpCategoryListByParentId",
			data: {
				parentCategory_id: "None"
			},
			success: function(res) {
				res.forEach(element => {
					$("#helpCategory").append(
						$("<option>").prop(
							{
								value: element.helpCategory_id,
								text: element.name
							}
						)
					)					
					$("#testHelpCategory").append(
						$("<option>").prop(
							{
								value: element.helpCategory_id,
								text: element.name
							}
						)
					)					
				})
			}
		})
		// FAQ 테스트
		$("#faqOneBtn").click(function() {
			$.ajax({
				url: "faqOne",
				data: {
					faq_id: $("#faqId").val()
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
					faq_id: $("#faqId").val(),
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
		$("#noticeOneBtn").click(function() {
			$.ajax({
				url: "noticeOne",
				data: {
					notice_id: $("#noticeId").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#noticeListBtn").click(function() {
			$.ajax({
				url: "noticeList",
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#noticeCreateBtn").click(function() {
			$.ajax({
				url: "../admin/noticeCreate",
				type: "POST",
				data: {
					admin_id: $("#noticeAdminId").val(),
					title: $("#noticeTitle").val(),
					content: $("#noticeContent").val(),
					tag: $("#noticeTag").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#noticeUpdateBtn").click(function() {
			$.ajax({
				url: "../admin/noticeUpdate",
				type: "POST",
				data: {
					notice_id: $("#noticeId").val(),
					admin_id: $("#noticeAdminId").val(),
					title: $("#noticeTitle").val(),
					content: $("#noticeContent").val(),
					tag: $("#noticeTag").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		// 1:1 문의 테스트
		$("#contactOneBtn").click(function() {
			$.ajax({
				url: "contactOne",
				data: {
					contact_id: $("#contactId").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		$("#contactListBtn").click(function() {
			$.ajax({
				url: "contactList",
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
		
		$("#answerUpdateBtn").click(function() {
			$.ajax({
				url: "/dorae/admin/answerUpdate",
				type: "POST",
				data: {
					contact_id: $("#contactId").val(),
					admin_id: $("#answerAdminId").val(),
					answer: $("#answer").val()
				},
				success: function(res) {
					console.log(res);
				}
			})
		});
		
		// 문의 유형 테스트
		$("#hcNameUpdateBtn").click(function() {
			$.ajax({
				url: "/dorae/admin/hcNameUpdate",
				type: "POST",
				data: {
					helpCategory_id: $("#testHelpCategory").val(),
					name: $("#helpCategoryName").val(),
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
	
	<p>번호 : <input id="faqId"/></p>
	<p>제목 : <input id="faqTitle"/></p>
	<p>내용 : <input id="faqContent"/></p>
	<p>검색 : <input id="faqSearch"/></p>
	<select id="helpCategory">
		<option value="None">문의 유형</option>
	</select>
	
	<button id="faqOneBtn">FAQ 단건</button>
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
	
	
	<p>번호 : <input id="noticeId"/></p>
	<p>관리자 : <input id="noticeAdminId" value="sla@naver.com"/></p>
	<p>제목 : <input id="noticeTitle"/></p>
	<p>내용 : <input id="noticeContent"/></p>
	<p>태그 : <input id="noticeTag"/></p>
	
	<button id="noticeOneBtn">공지사항 단건</button>
	<button id="noticeListBtn">공지사항 목록</button>
	<button id="noticeCreateBtn">공지사항 등록</button>	
	<button id="noticeUpdateBtn">공지사항 수정</button>	
	
	<hr color="red">
	<div id="noticeResult"></div>
	<hr color="orange">
	
	<!--  -->
	<h2>1:1 문의 테스트</h2>
	
	<p>번호 : <input id="contactId"/></p>
	<p>회원 : <input id="contactMemberId" value="abcd@naver.com"/></p>
	<p>제목 : <input id="contactTitle"/></p>
	<p>관리자 : <input id="answerAdminId" value="sla@naver.com"/></p>
	<p>답변 : <input id="answer"/></p>
	<button id="contactOneBtn">1:1 문의 단건</button>
	<button id="contactListBtn">1:1 문의 목록</button>
	<button id="contactCreateBtn">1:1 문의 등록</button>
	<button id="answerUpdateBtn">1:1 답변 등록</button>
	
	<hr color="red">
	<div id="contactResult"></div>
	<hr color="orange">
	
	<!--  -->
	<h2>문의 유형 테스트</h2>
	
	<select id="testHelpCategory">
		<option value="None">문의 유형</option>
	</select>
	<p>유형 이름 : <input id="helpCategoryName"/></p>
	<button id="hcNameUpdateBtn">유형 이름 수정</button>
	
	<hr color="red">
	<div id="contactResult"></div>
	<hr color="orange">
	
</body>
</html>