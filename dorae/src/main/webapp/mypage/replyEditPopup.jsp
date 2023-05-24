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
	
	<!-- WEB-INF/views/mypage 안에 replyUpdate.jsp로 이동 -->
	<form action="../mypage/replyUpdate" id="editForm">
	
		<div>
			<!-- text(글내용) 수정하는 곳 -->
			<textarea name="text" maxlength="300">${param.text}</textarea>
			<!-- type을 hidden으로 하면 input 내용 안보임 -->
			<input type="hidden" name="r_number" value="${param.r_number}">
		</div>
		
		<div>
			<!-- 저장버튼을 id를 줘서 script로 자바코드를 짜주려고 했는데 실행이 안돼서 submit으로 했더니 성공 -->
			<button type="submit">저장</button>
			<button type="button" onclick="window.close()">닫기</button>
		</div>
		
	</form>
</body>
</html>