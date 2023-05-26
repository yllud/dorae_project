<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/dorae/resources/css/sidebars.css">
<script type="text/javascript" src="/dorae/resources/js/jquery-3.6.4.js"></script>
<style type="text/css">
	.nav-link {
		width: 100%;
		text-align: left;
	}
	
	.align-middle {
		vertical-align: middle;
	}
	
	.btn-link {
		padding: 0;
	}
</style>
</head>
<body>
	<div class="d-flex flex-nowrap">
		<div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" style="width: 280px;">
			<a href="/dorae/admin" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
				<span class="fs-4">관리자 페이지</span>
			</a>
			<hr>
			<ul class="nav nav-pills flex-column mb-auto">
				<li><button value="/dorae/admin/contact/list?page=1" class="nav-link text-white" aria-current="page" onclick="setActive(this)"> 1:1 문의 목록 </button></li>
				<li><button value="/dorae/admin/faq/list?help_category_id=D01&page=1" class="nav-link text-white" onclick="setActive(this)">FAQ 목록 </button></li>
				<li><button value="/dorae/admin/faq/create" class="nav-link text-white" onclick="setActive(this)">FAQ 등록 </button></li>
				<li><button value="/dorae/admin/notice/list?page=1" class="nav-link text-white" onclick="setActive(this)">공지사항 목록 </button></li>
				<li><button value="/dorae/admin/notice/create" class="nav-link text-white" onclick="setActive(this)">공지사항 등록 </button></li>
			</ul>
			<hr>
			
			<div class="dropdown">
				<button class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"
					style="background-color: transparent; border: 0;">
					<strong>${adminVO.id }</strong>
				</button>
				<ul class="dropdown-menu dropdown-menu-dark text-small shadow">
					<li><a class="dropdown-item" href="#">New project...</a></li>
					<li><a class="dropdown-item" href="#">Settings</a></li>
					<li><a class="dropdown-item" href="#">Profile</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="admin/logout">로그아웃</a></li>
				</ul>
			</div>
		</div>
		<div class="b-example-divider b-example-vr"></div>
		
		<div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">		    
		    <div id="contents"><!-- 목록 들어가는 곳 -->
		    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="h2">관리자 페이지입니다.</h1>
			</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function setActive(element) {
			let temp = document.getElementsByClassName("active")[0];
			
			if (temp != null) {
				temp.classList.remove("active");
				temp.classList.add("text-white");				
			}
			
			element.classList.remove("text-white");
			element.classList.add("active");
			
			goToPage(element);
		}
		
		function goToPage(element) {
			asyncLoad(element.getAttribute("value"));
			console.log(element.getAttribute("value"));
			//history.pushState({"url": element.getAttribute("value")}, null, element.getAttribute("value"));
			history.pushState({"url": element.getAttribute("value")}, null, location.pathname);
		}
		
		function asyncLoad(url) {
			$.ajax({
				url: url,
				success: function(data, statusText, jqXHR) {
					$("#contents").html(data);
					console.log(data);
					console.log(statusText);
					console.log(jqXHR);
					console.log(jqXHR.getResponseHeader("Test-header"));
					if (jqXHR.getResponseHeader("invalidated") != null) {
						location.href = jqXHR.getResponseHeader("Test-header");
					}
				}
			})			
		}
		
		window.onpopstate = function(event) {
			console.log(event.state);
			if (event.state != null) { // state 가 null 이 아닐 때만 ajax로 갱신
				asyncLoad(event.state.url);				
			}
		}
		
	</script>
</body>
</html>