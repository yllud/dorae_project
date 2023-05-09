<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('#b1').click(function() {
			//기존의 것 삭제됨.
			$('#result').empty()
			$.ajax({
				url : "bbs_list",
				success : function(x) {
					$('#result').append(x)
				} //success
			}) //ajax
		})//b1
		$('#b2').click(function() {
			$('#result').empty()
			$.ajax({
				url : "reply_list",
				data : {
					bbsno : 1
				},
				success : function(x) {
					$('#result').append(x)
				} //success
			}) //ajax
		})//b2
		
		$('#b3').click(function() {
			$('#result').empty()
			$.ajax({
				url : "reply_list",
				data : {
					bbsno : 30
				},
				success : function(x) {
					$('#result').append(x)
				} //success
			}) //ajax
		})//b2
		
		$('#b5').click(function() {
			$('#result').empty()
			$.ajax({
				url : "bbs_list_writer",
				data : {
					writer : "apple"
				},
				success : function(x) {
					$('#result').append(x)
				} //success
			}) //ajax
		})//b2
		
		$('#b6').click(function() {
			$('#result').empty()
			$.ajax({
				url : "reply_list_writer",
				data : {
					writer : "apple"
				},
				success : function(x) {
					$('#result').append(x)
				} //success
			}) //ajax
		})//b2
		
		$('#b7').click(function() {
			$('#result').empty()
			$.ajax({
				//url : "http://api.openweathermap.org/data/2.5/weather?q=seoul&units=metirc&lang=kr&appid=43238037f8f84c1b9d70369513a425e6",
				crossOrigin: true,
				//crossOrigin: true,
				url:'https://api.openweathermap.org/data/2.8/onecall?lat='+ lat +'&lon='+lon+'&exclude=hourly,daily,minutely&appid=43238037f8f84c1b9d70369513a425e6',
				dataType : 'json',
				success : function(x) {
					$('#result').html("현재 위도, 경도 "+x.lat+ " , " + x.lon+"<br>"+
							"날씨 "+x.current.weather[0].description+"<br>"+
							"풍속 "+x.current.wind_speed+" m/s<br>"+
							"기온 "+(x.current.temp - 273.15).toFixed(1) + "°C<br>" +
							"체감 온도 "+(x.current.feels_like - 273.15).toFixed(1) + "°C<br>" +
							"구름 "+x.current.clouds+"%<br>")
				} //success
			}) //ajax
		})//b2
	})//$

	
</script>
<!-- http://api.openweathermap.org/data/2.5/weather?q=seoul&units=metirc&lang=kr&appid=43238037f8f84c1b9d70369513a425e6 -->
</head>
<body>
<button id="b1">bbs리스트 가지고 오기</button>
<button id="b2">bbs번호 1번 reply리스트 가지고 오기</button>
<button id="b3">bbs번호 30번 reply리스트 가지고 오기</button>
<button id="b4">id가 apple인사람의 정보 가지고 오기</button>
<button id="b5">id가 apple인사람의 게시글 가지고 오기</button>
<button id="b6">id가 apple인사람의 게시글 가지고 오기</button>
<button id="b7">api 데이터 가지고 오기</button>
<hr color="red">
<div id="result" style="background: yellow"></div>
</body>
</html>