<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>후기 작성</title>
<link rel="stylesheet" href="../resources/css/reviewInsertUp.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	function showSuccessMessage() {
		alert("저장이 완료되었습니다.");
	}
	// 태그할 공연 검색창 열기
	function openPopup() {
		window.open("tag.jsp", "_blank", "width=700,height=600");
	}
</script>
</head>
<body>
<div class="total">
	<form action="insert" method="post" enctype="multipart/form-data"
		onsubmit="return showSuccessMessage()">
		<table id="insertTable">
		<tr>
		<td><span>행사명</span></td>
		<td>
		<div class="tagSelect">
		<button type="button" onclick="openPopup()" id="tagSelectBtn">행사명 선택</button>
		<input type="text" name="tag" id="selectedEventName" readonly>
		</div>
		</td>
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
		<td><span>내용</span></td>
		<td><textarea name="content" placeholder="1000자 내로 작성 부탁드립니다." maxlength="1000"></textarea></td>
		<tr>
		<td colspan=2>
		<div class="submitDiv">
		<button type="submit" class="submitBtn">후기 등록</button>
		</div>
		</td>
		</tr>
		</table>
	</form>

</div>
</body>
</html>