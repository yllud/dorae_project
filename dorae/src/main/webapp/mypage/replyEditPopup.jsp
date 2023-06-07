<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 수정</title>
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
	height: 80px;
	resize: none;
}

.button-area button {
	margin-right: 5px;
}
</style>
</head>
<body>
	<h2>후기 수정</h2>
	
	<form action="../mypage/replyUpdate" id="editForm">
	
		<div>
			<textarea name="text" maxlength="300">${param.text}</textarea>
			<input type="hidden" name="r_number" value="${param.r_number}">
		</div>
		
		<div>
			<button type="submit" id="saveButton">저장</button>
			<button type="button" onclick="window.close()">닫기</button>
		</div>
		
	</form>

	<script>
		document.getElementById("saveButton").addEventListener("click", function() {
			window.opener.location.reload();
		});
	</script>
</body>
</html>