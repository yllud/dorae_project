<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.multi.dorae.login.NaverVO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script>
    function checkPasswordMatch() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var passwordMatchMessage = document.getElementById("passwordMatchMessage");

        if (password === confirmPassword) {
            passwordMatchMessage.innerHTML = "비밀번호가 일치합니다.";
            passwordMatchMessage.style.color = "green";
        } else {
            passwordMatchMessage.innerHTML = "비밀번호가 일치하지 않습니다.";
            passwordMatchMessage.style.color = "red";
        }
    }
</script>

</head>
<body>
<form action="../mypage/memberUpdate" method="POST">

    <label for="nickname">닉네임</label>
    <input type="text" id="nickname" name="nickname" value="${vo2.nickname}"><br>
        
    <label for="password">비밀번호</label>
    <input type="password" id="password" name="password" minlength="6"><br>
        
    <label>비밀번호 확인</label>
    <input type="password" id="confirmPassword" name="confirmPassword" oninput="checkPasswordMatch()" minlength="6"><br>
    <span id="passwordMatchMessage"></span><br>
        
    <label>연령대&nbsp;&nbsp;</label> <select name="age">
        <option value="0-9">0-9세</option>
        <option value="10-19">10-19세</option>
        <option value="20-29">20-29세</option>
        <option value="30-39">30-39세</option>
        <option value="40-49">40-49세</option>
        <option value="50-59">50-59세</option>
        <option value="60+">60세 이상</option>
    </select><br>
        
    <button type="submit">수정</button>
</form>
</body>
</html>