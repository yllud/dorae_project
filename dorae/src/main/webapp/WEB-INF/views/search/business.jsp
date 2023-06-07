<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="../resources/css/search.css"> -->
<title>Insert title here</title>
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/dorae/resources/css/businessSidebars.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/themes/material_blue.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/ko.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/plugins/minMaxTimePlugin.min.js"></script>

<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			type : 'post',
			url : "businessList",
			data : {
				page : 1,
				email : $('#email_id').val(),

			},

			success : function(x) {

				$('#contents').html(x)
			},//success
			error : function() {
				alert('실패.@@@')
			}//error
		})//ajax

		$('#btnList').click(function() {
			//기존의 것 삭제됨.
			$('#contents').empty()

			$.ajax({
				type : 'post',
				url : "businessList",
				data : {
					page : 1,
					email : $('#email_id').val(),

				},

				success : function(x) {

					$('#contents').html(x)
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		})//btnList
		
		
		$('#btnDelete').click(function() {
			//기존의 것 삭제됨.
			$('#contents').empty()

			$.ajax({
				type : 'post',
				url : "businessDeleteList",
				data : {
					page : 1,
					email : $('#email_id').val(),

				},

				success : function(x) {

					$('#contents').html(x)
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		})//btnList
		


	})//$
</script>

</head>
<body>

	<input id="email_id" type="hidden"
		value="<%=session.getAttribute("email")%>">

	<div class="d-flex flex-nowrap">
		<div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark"
			style="width: 280px;">
			<a href="#"
				class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
				<span class="fs-4">사업자 페이지</span>
			</a>
			<hr>
			<ul class="nav nav-pills flex-column mb-auto">
				<li><button id="btnList"
						class="nav-link text-white" aria-current="page"
						onclick="setActive(this)">공연 목록</button></li>
				<li><button id="btnDelete" class="nav-link text-white" onclick="setActive(this)">삭제
						공연 목록</button></li>
			</ul>
			<hr>
		</div>
		<div class="b-example-divider b-example-vr"></div>

		<div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<div id="contents">
				<!-- 목록 들어가는 곳 -->
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">공연 목록</h1>
				</div>
			</div>
		</div>
	</div>

</body>
</html>