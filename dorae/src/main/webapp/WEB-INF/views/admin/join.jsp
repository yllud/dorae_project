<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 가입 페이지</title>
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/dorae/resources/css/signin.css">
</head>
<body>
	<main class="form-signin w-100 m-auto">
	  <form action="join" method="post">
	    <h1 class="h3 mb-3 fw-normal">관리자 가입</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" id="floatingID" name="id" placeholder="아이디">
	      <label for="floatingID">아이디</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="비밀번호">
	      <label for="floatingPassword">비밀번호</label>
	    </div>
	    <div class="form-floating">
	      <input type="text" class="form-control" id="floatingName" name="name" placeholder="이름">
	      <label for="floatingName">이름</label>
	    </div>
	    <div class="form-floating">
	      <input type="text" class="form-control" id="floatingNickName" name="nickname" placeholder="닉네임">
	      <label for="floatingNickName">닉네임</label>
	    </div>
	    
	    <button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
	  </form>
	</main>
</body>
</html>