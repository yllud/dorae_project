<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기수정</title>
<link rel="stylesheet" href="/dorae/resources/css/reviewInsertUp.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	function openPopup() {
		window.open("tag.jsp", "_blank", "width=700,height=600");
	}
</script>
</head>
<body>
	<form action="imgUpdate" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td><input type="hidden" name="email" value="${review.email}">
					<input type="hidden" name="id" value="${review.id}"> <input
					type="file" name="files" multiple></td>
				<td><button type="submit">사진 수정</button></td>
			</tr>
		</table>
	</form>
	<hr color="#ff9900">
	<form action="update2" method="post">
		<table>
			<tr>
				<td colspan="2"><input type="hidden" name="id"
					value="${review.id}"></td>
			</tr>
			<tr>
				<td><span>행사명</span></td>
				<td>
				<div class="tagSelect">
					<button type="button" onclick="openPopup()">행사명 선택</button>
					<input type="text" name="tag" value="${review.tag}"
					id="selectedEventName" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td><span>제목</span></td>
				<td><input type="text" name="title" value="${review.title}"></td>
			</tr>
			<tr>
				<td><span>내용</span></td>
				<td><textarea name="content" maxlength="1000">${review.content}</textarea></td>
			</tr>
			<tr>
				<td colspan=2>
					<button type="submit" id="submitBtn">후기 수정</button>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>