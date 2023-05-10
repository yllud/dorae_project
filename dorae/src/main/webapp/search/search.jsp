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

		$('#b0').click(function() {
			//기존의 것 삭제됨.
			$('#result').empty()

			$.ajax({
				url : "playList",
				success : function(x) {
					$('#result').append(x)
				}
			})
		})//b1

		$('#b1').click(function() {
			//기존의 것 삭제됨.
			$('#result').empty()

			$.ajax({
				url : "playSearch",
				data : {
					title : $('#title').val()
				},
				success : function(x) {
					//alert(x)
					$('#result').append(x)
				},//success
				error : function() {
					alert('검색 실패')
				}//error
			})//ajax
		})//b0

	})//$
</script>

</head>
<body>
	<h3>공연검색 화면</h3>
	<!-- 	<form action="bbs_one" method="get"> -->
	<!-- 		id : <input name="no" value="1"><br> -->
	<!-- 		<button type="submit">서버로 전송</button> -->
	<!-- 	</form> -->


	<button id="b0">공연 리스트 가지고 오기(20개)</button>
	<hr color="red">

	공연 제목:
	<input id="title">
	<button id="b1">검색</button>
	<hr color="red">


<!-- 	<button id="b2">전체</button> -->
<!-- 	<button id="b3">연극</button> -->
<!-- 	<button id="b4">무용(서양/한국무용)</button> -->
<!-- 	<button id="b5">대중무용</button> -->
<!-- 	<button id="b6">클래식(서양음악)</button> -->
<!-- 	<button id="b7">국악(한국음악)</button> -->
<!-- 	<button id="b8">대중음악</button> -->
<!-- 	<button id="b9">복합</button> -->
<!-- 	<button id="b10">서커스/마술</button> -->
<!-- 	<button id="b11">서커스/마술</button> -->
<!-- 	<button id="b12">뮤지컬</button> -->

	<hr color="red">
	<div id="result"></div>
	<!-- 	<div id="result" style="background: yellow"></div> -->

</body>
</html>