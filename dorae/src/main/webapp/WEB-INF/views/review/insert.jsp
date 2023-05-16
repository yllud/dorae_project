<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
저장이 완료되었습니다.<br>
이미지 업로드 성공! <img src="../resources/upload/${reviewVO.img}" width=300 height=300><br>
제목 : ${reviewVO.title}<br>
내용 : ${reviewVO.content}<br>
행사명 : ${reviewVO.tag}
</body>
</html>