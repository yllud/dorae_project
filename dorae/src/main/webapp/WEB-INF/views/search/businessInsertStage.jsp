<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/dorae/resources/css/businessSidebars.css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		function searchStage(){
			//기존의 것 삭제됨.
			$('#result2').empty()

			$.ajax({
				url : "businessInsertStage2",
				data : {
					title : $('#title').val()
				},
				success : function(x) {
					$('#result2').html(x)
				},//success
				error : function() {
					alert('실패.@@@')
				}//error
			})//ajax
		}
		
		
		//버튼 눌러서 입력
		$('#findStage').click(function() {
			// 기존의 것 삭제됨.
// 			$('#result').empty();

			searchStage();
		});

		//enter 키로 입력
		$('#title').keypress(function(event) {
			if (event.keyCode === 13) {
				searchStage();
			}
		});

	})//$
</script>
<style type="text/css">
.date {
	width: 80px;
	/*   height:100px; */
	/*   font-size:20px; */
}
</style>
</head>
<body>
<div class="new-page-stage">
	<div
		class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
		<h1 class="h2">공연장 검색</h1>
	</div>


	<input id="title">
	<button id="findStage">검색</button>
	<div id="result2"></div>
</div>
</body>
</html>