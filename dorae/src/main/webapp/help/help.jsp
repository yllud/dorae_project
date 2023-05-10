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
					$("#result").html(res);
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
	})
</script>
</head>
<body>
	<button id="faqListBtn">faqList</button>
	<input type="text" id="faqSearch"><button id="faqSearchBtn">faqSearch</button>
	<button id="noticeListBtn">noticeList</button>
	<button id="contactListBtn">contactList</button>
	<hr color="red">
	
	<div id="result">
	</div>
</body>
</html>