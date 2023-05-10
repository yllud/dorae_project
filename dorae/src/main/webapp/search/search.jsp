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
		$('#b1').click(function() {
			$.ajax({
				url : "../search/playList",
				success : function(x) {
					$('#result').append(x)

				}

			})
		})//b1

		// $('#b2').click(
		// 				function() {
		// 					$('#result').empty()
		// 					$.ajax({
		// 						url : "list_json",
		// 						dataType : "json",
		// 						success : function(json) {

		// 							for (i = 0; i < json.length; i++) {
		// 								no = json[i].id
		// 								writer = json[i].pw
		// 								title = json[i].name
		// 								content = json[i].tel

		// 								$('#result').append(
		// 										no + " " + writer + " " + title + " "
		// 												+ content + "<br>")
		// 							}
		// 						}

		// 					})
		// 				})

		// 		$('#b2').click(function() {
		// 			$('#result').empty()
		// 			$.ajax({
		// 				url : "reply_list",
		// 				data : {
		// 					bbsno : 1
		// 				},
		// 				success : function(x) {
		// 					$('#result').append(x)
		// 				} //success
		// 			}) //ajax
		// 		})//b2

	})//$
</script>

</head>
<body>
	<button id="b1">play리스트 가지고 오기</button>
	<!-- <button id="b2">bbs번호 1번 reply리스트 가지고 오기</button> -->

	<hr color="red">
	<div id="result" style="background: yellow"></div>

</body>
</html>