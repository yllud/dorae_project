<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	function showSuccessMessage1() {
    	alert("게시글 수정이 완료되었습니다.");
	}
	
	function showSuccessMessage2() {
    	alert("사진 수정이 완료되었습니다.");
	}
</script>
</head>
<body>
<form action="update2" method="post" onsubmit="showSuccessMessage1()">
<input type="hidden" name="id" value="${review.id}">
  <span>행사명</span><input type="text" name="tag" value="${review.tag}"><br>
  <span>제목</span><input type="text" name="title" value="${review.title}"><br>
  <span>후기내용</span><input type="text" name="content" value="${review.content}"><br>
  <button type="submit">후기 수정</button>
</form>
<br>
<form action="imgUpdate" method="post" enctype="multipart/form-data" onsubmit="showSuccessMessage2()">
  <span>사진수정</span>
  <input type="hidden" name="email" value="${review.email}">
  <input type="hidden" name="id" value="${review.id}">
  <input type="file" name="files" multiple><br>
  <button type="submit">사진 수정</button>
</form>
</body>
</html>