<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript"
	src="../resources/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

</head>
<body>

<% if(session.getAttribute("email") == null){ %>
	<h3>로그인페이지 입니다.</h3>
	<hr color="orange">
	
	<form action="../login/memberLogin" method="get">
	아이디 : <input name="email"><br>
	<!-- 비밀번호 type을 password로 하면 입력할 때 점으로 표시 됨 -->
	비밀번호 : <input type="password" name="password"><br>
	<button type="submit">로그인</button>
</form>
	<a href="../login/memberCreate.jsp">회원가입</a>

	<div id="naver_id_login"></div>
    <!-- //네이버 로그인 버튼 노출 영역 -->
    <script type="text/javascript">
        var naver_id_login = new naver_id_login("AMkeOwuTJY71fYcpifZl", "http://localhost:8888/dorae/login/callback.jsp");
        var state = naver_id_login.getUniqState();
        naver_id_login.setButton("green", 10,60);
        naver_id_login.setDomain("http://localhost:8888/dorae");
        naver_id_login.setState(state);
        //naver_id_login.setPopup();
        naver_id_login.init_naver_id_login();
    </script>
	<br>
	
	<!-- 카카오 로그인 -->
	<a class="p-2"
		href="https://kauth.kakao.com/oauth/authorize?client_id=7d82a34e6c4c00f0c8af6bad0d046044&redirect_uri=http://localhost:8888/dorae/login/kakaoLogin&response_type=code">
		<!-- REST_API키 및 REDIRECT_URi는 본인걸로 수정하세요 --> 
		<img src="../resources/img/kakaoLogo.png" style="height: 60px">
	</a>
	
	<%}else{ %>
	out.println("<script type='text/javascript'>alert('${nickname} 님이 로그인 하셨습니다');location.href = 'http://localhost:8888/dorae/map/main.jsp'</script>");
	<%} %>
</body>
</html>