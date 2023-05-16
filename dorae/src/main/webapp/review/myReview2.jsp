<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="insert2" method="post" enctype="multipart/form-data">
  <span>행사명</span><input type="text" name="tag"><br>
  <span>제목</span><input type="text" name="title"><br>
  <span>사진첨부</span>
  <input type="file" name="files" multiple><br>
  <span>후기내용</span><input type="text" name="content"><br>
  <button type="submit">후기 등록</button>
</form>


</body>
</html>