<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min2.css">
<link rel="stylesheet" href="/dorae/resources/css/businessSidebars.css">
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
				<li><button value="/dorae/admin/faq/list?page=1" class="nav-link text-white" onclick="setActive(this)">FAQ 목록 </button></li>
				<li><button value="/dorae/admin/faq/create" class="nav-link text-white" onclick="setActive(this)">FAQ 등록 </button></li>
				<li><button value="/dorae/admin/notice/list?page=1" class="nav-link text-white" onclick="setActive(this)">공지사항 목록 </button></li>
				<li><button value="/dorae/admin/notice/create" class="nav-link text-white" onclick="setActive(this)">공지사항 등록 </button></li>
				<li><button value="/dorae/admin/apply/list?page=1" class="nav-link text-white" onclick="setActive(this)">사업자 신청 목록 </button></li>
			</ul>
			<hr>
			
			<div class="d-flex">
				<strong class="flex-grow-1">${adminVO.id }</strong>
				<a class="text-light" style="text-decoration: none;" href="admin/logout">로그아웃</a>
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
		
		function goToPage(element, isReplace) {
			if (isReplace) {
				history.replaceState({"url": element.getAttribute("value")}, null, location.pathname);
			} else {
				history.pushState({"url": element.getAttribute("value")}, null, location.pathname);				
			}
			asyncLoad(element.getAttribute("value"));
		}
		
		function asyncLoad(url, type, data) {
			$.ajax({
				url: url,
				type: type,
				data: data,
				success: function(res, statusText, jqXHR) {
					console.log(statusText);
					console.log(jqXHR);
					if (jqXHR.getResponseHeader("invalidated") != null) {
						location.href = jqXHR.getResponseHeader("invalidated");
					}
					$("#contents").html(res);
				}
			})			
		}
		
		window.onpopstate = function(event) {
			console.log(event);
			console.log(event.state);
			if (event.state != null) { // state 가 null 이 아닐 때만 ajax로 갱신
				asyncLoad(event.state.url);				
			}
		}
		
	</script>
</body>
</html>