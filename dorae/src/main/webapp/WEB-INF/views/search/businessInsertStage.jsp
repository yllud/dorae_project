<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('#findStage').click(function() {
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
		})//b0

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
공연장 검색: <input id="title"> <button id="findStage">검색</button>
<div id="result2"></div>

</body>
</html>