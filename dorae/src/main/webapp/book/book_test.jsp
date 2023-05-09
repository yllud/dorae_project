<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3>데이터를 입력하세요 </h3>
<form action="insert_book" method="get">
	이메일 : <input name="email" value="abc123@naver.com"><br>
	공연id : <input name="play_id" value="PF121682"><br>
	<button type="submit" >서버로 전송</button>
</form>
<hr color="red">

<h3>삭제 화면입니다.</h3>
<form action="delete_book" method="get">
	공연id : <input name="play_id" ><br>
	<button type="submit">서버로 전송</button>
</form>
<hr color="red">

<h3>북마크 검색</h3>
<form action="all_book" method="get">
	이메일 : <input name="email" value=6><br>
	<button onclick="alert('all_book이 요청됨!');" type="submit">검색</button>
</form>
<hr color="red">

</body>
</html>