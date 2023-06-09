<!-- sidemenu.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
table{
	max-width: 350px;
	margin: 0 auto;
	padding: 10px;
}
th, td {
  text-align: center;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "infoList",
			contentType: "application/json; charset=UTF-8",
			dataType: "json", // 데이터 형식을 JSON으로 지정
			success : function(data) {
				var response = data;

				// delist1과 delist2 추출
				var delist1 = response.delist1;
				var delist2 = response.delist2;
				
				// 테이블 생성
				var table = '<table>';
				for (var i = 0; i < delist1.length; i++) {
					var item = delist1[i];
					table += '<tr><td><img src="' + item.poster + '"></td></tr>';
					table += '<tr><td>' + item.play_name + '</td></tr>';
					table += '<tr><td>' + item.play_start + " ~ " + item.play_end + '</td></tr>';
					table += '<tr><td>' + item.stage_name + '</td></tr>';
				}
				table += '</table>';

				// 테이블 추가
				$('#infolist').html(table);
			}, //success
			error : function() {
				alert('실패@@@');
			}
		}); //ajax
	});
</script>
</head>
<link rel="stylesheet" href="../resources/css/sidemenu.css" />
<body>
	<div class="left-side-bar">		
		<input id="address_input" type="text" placeholder="도로명주소를 검색해주세요">
		<div id="infolist"></div>
	</div>
</body>
</html>