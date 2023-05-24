<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
input[type="text"] {
	width: 100%;
	box-sizing: border-box;
	padding: 5px;
}

textarea {
	width: 100%;
	height: 200px; /* Adjust the height as desired */
	box-sizing: border-box;
	padding: 5px;
}

#content {
	height: 300px;
}

button[type="submit"], button[type="button"] {
	padding: 10px;
}

table {
	width: 70%;
}

table td {
	padding: 5px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	function showSuccessMessage() {
		alert("저장이 완료되었습니다.");
	}
	// 태그할 공연 검색창 열기
	function openPopup() {
		window.open("tag.jsp", "_blank", "width=500,height=500");
	}
</script>
</head>
<body>

	<form action="insert" method="post" enctype="multipart/form-data"
		onsubmit="showSuccessMessage()">
		<table>
		<tr>
		<td><span>행사명</span></td>
		<td><button type="button" onclick="openPopup()">행사명 선택</button>
		<input type="text" name="tag" id="selectedEventName" readonly></td>
		</tr>
		<tr>
		<td><span>제목</span></td>
		<td><input type="text" name="title"></td>
		</tr>
		<tr>
		<td><span>사진첨부</span></td>
		<td><input type="file" name="files" multiple></td>
		</tr>
		<tr id = "content">
		<td><span>후기내용</span></td>
		<td><textarea name="content" placeholder="1000자 내로 작성 부탁드립니다." maxlength="1000"></textarea></td>
		</table>
		<button type="submit">후기 등록</button>

	</form>


</body>
</html>