<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 페이지</title>
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/dorae/resources/css/signin.css">
<style type="text/css">
	.nav-link {
		text-align: center;
	}
</style>
</head>
<body>
	<main class="form-signin w-100 m-auto">
		<form action="login" method="post">
			<h1 class="h3 mb-3 fw-normal">관리자 로그인</h1>

			<div class="form-floating">
				<input type="text" class="form-control" id="floatingID" name="id" placeholder="아이디">
				<label for="floatingID">아이디</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="floatingPassword" name="password" placeholder="비밀번호">
				<label for="floatingPassword">비밀번호</label>
			</div>
			
			<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
		</form>
		<hr>
		
		<a class="w-100 btn btn-lg btn-danger" href="join">관리자 가입</a>
		<hr>
		
		<a class="nav-link" href="find">아이디/비밀번호 찾기</a>
	</main>
</body>
</html>