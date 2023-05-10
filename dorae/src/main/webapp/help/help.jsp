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
					$("#result1").html(res);
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
		
		$("#contactListBtn").click(function() {
			$.ajax({
				url: "contactList",
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
					title: $("#title").val(),
					content: $("#content").val()
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
	<button id="faqListBtn">faqList</button>
	<input type="text" id="faqSearch"><button id="faqSearchBtn">faqSearch</button>
	<button id="noticeListBtn">noticeList</button>
	<button id="contactListBtn">contactList</button>
	<hr color="red">
	
	<div id="result1">
	</div>
	<hr color="blue">
	
	<select id="helpCategory">
		<option value="asdf">asdf</option>
	</select>
	<input id="title"/>
	<input id="content"/>
	<button id="faqCreateBtn">FAQ 등록</button>
	<hr color="red">
	
	<div id="result2">
	</div>
</body>
</html>