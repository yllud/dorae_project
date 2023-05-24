<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 작성</title>
<style>
body {
	text-align: center;
	padding: 20px;
	background-color: #f1f1f1;
	font-family: Arial, sans-serif;
}

.close {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
}

.input-area {
	margin-bottom: 10px;
}

.button-area {
	margin-top: 20px;
}

textarea {
	width: 100%;
	height: 100px;
	resize: none;
}

.button-area button {
	margin-right: 5px;
}
</style>
</head>
<body>
	<span class="close" onclick="window.close()">&times;</span>
	<h2>후기 작성</h2>
	<form action="replyInsert" method="get">
	<div class="input-area">
		<textarea placeholder="내용 입력 (최대 300글자)" id="inputText" name="text"
			maxlength="300"></textarea>
			<input type="hidden" name="email" value="${email}"><br>
			작성자 : ${nickname} <input type="hidden" name="nickname" value="${nickname}"><br>
	</div>
	<div class="button-area">
		<button onclick="confirmPopup()">확인</button>
		<button onclick="window.close()">닫기</button>
	</div>
	</form>

	<script>
		function confirmPopup() {
			var inputText = document.getElementById("inputText").value;
			// 여기에서 입력된 내용을 처리하는 로직을 추가하세요.
			console.log("입력된 내용: " + inputText);
		}
	</script>
</body>
</html>