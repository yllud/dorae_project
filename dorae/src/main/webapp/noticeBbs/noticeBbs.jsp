<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {
		$("#header").load("../header/header.jsp");
		// 페이지 로드 시
		$.ajax({
			url : "all",
			data : {
				page : 1
			},
			success : function(result) {
				$('#result').html(result);
			},
			error : function(xhr, status, error) {
				alert('에러 발생');
			}
		})
		
		// 전체 목록 클릭 시
		$('#total').click(function() {
			$.ajax({
				url : "all",
				data : {
					page : 1
				},
				success : function(result) {
					$('#result').html(result);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			})
		})
		
		// 공지사항 목록 클릭 시
		$('#notice').click(function() {
			$.ajax({
				url : "tag",
				data : {
					page : 1,
					tag : "공지사항"
				},
				success : function(result) {
					$('#result').html(result);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			})
		})
		
		$('#event').click(function() {
			$.ajax({
				url : "tag",
				data : {
					page : 1,
					tag : "이벤트"
				},
				success : function(result) {
					$('#result').html(result);
				},
				error : function(xhr, status, error) {
					alert('에러 발생');
				}
			})
		})
		
	})
	
	
</script>
<style>
  .tab-container {
    display: flex;
    justify-content: center;
    margin-bottom: 10px;
  }

  .tab {
    cursor: pointer;
    padding: 10px;
    border: 1px solid #ccc;
    background-color: #f2f2f2;
    margin-right: 5px;
    flex: 1;
    text-align: center;
  }

  .active {
    background-color: #ccc;
  }
  
  #noticeBbs{
	margin-top: 175px;
}
</style>
</head>
<body>
<header id="header" class="fixed-top"></header>
<div id="noticeBbs">
	<div class="tab-container">
    <div class="tab" id="total">전체</div>
    <div class="tab" id="notice">공지사항</div>
    <div class="tab" id="event">이벤트</div>
  </div>
	<div id="result"></div>
	</div>
</body>
</html>