<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
.id_ok{
color:#008000;
display: none;
}

.id_already{
color:#6A82FB; 
display: none;
}
</style>
<script type="text/javascript" src="/dorae/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
function validateForm() {
	  var password = document.getElementById('password').value;
	  var confirmPassword = document.getElementById('confirmPassword').value;

	  if (password !== confirmPassword) {
	    document.getElementById('passwordMatchMessage').textContent = '비밀번호가 일치하지 않습니다.';
	    document.getElementById('passwordMatchMessage').style.color = 'red';
	    return false;
	  } else {
	    document.getElementById('passwordMatchMessage').textContent = '일치';
	    document.getElementById('passwordMatchMessage').style.color = 'green';
	  }
	  return true;
	}

	function checkPasswordMatch() {
	  var password = document.getElementById('password').value;
	  var confirmPassword = document.getElementById('confirmPassword').value;

	  if (password === confirmPassword) {
	    document.getElementById('passwordMatchMessage').textContent = '일치';
	    document.getElementById('passwordMatchMessage').style.color = 'green';
	  } else {
	    document.getElementById('passwordMatchMessage').textContent = '비밀번호가 일치하지 않습니다.';
	    document.getElementById('passwordMatchMessage').style.color = 'red';
	  }
	}
	function checkEmail() {
		  var email = $('#email').val();
		  var emailStatus = $('#emailStatus');

		  $.ajax({
		    url: '../login/checkEmail',
		    type: 'post',
		    data: { email: email },
		    success: function (response) {
		      if (response === 'duplicate') {
		        // 중복된 이메일인 경우 처리
		        emailStatus.text('중복된 이메일입니다.');
		        emailStatus.css('color', 'red');
		      } else if (response === 'not_duplicate') {
		        // 중복되지 않은 이메일인 경우 처리
		        emailStatus.text('사용 가능한 이메일입니다.');
		        emailStatus.css('color', 'green');
		      } else {
		        // 이외의 경우 처리
		        emailStatus.text('에러가 발생하였습니다.');
		        emailStatus.css('color', 'red');
		      }
		    },
		    error: function () {
		      emailStatus.text('에러가 발생하였습니다.');
		      emailStatus.css('color', 'red');
		    }
		  });
		}
</script>
</head>
<body>
<h3>회원가입 화면입니다. </h3>
<hr color="red">
<form action="../login/memberInsert" method="post" onsubmit="return validateForm()">
    이메일: <input type="text" id="email" name="email" oninput = "checkEmail()" >
	<span id="emailStatus"></span><br>
							
    비밀번호: <input type="password" id="password" name="password"><br>
    비밀번호 확인: <input type="password" id="confirmPassword" name="confirmPassword" oninput="checkPasswordMatch()"><br>
    <span id="passwordMatchMessage" style="color: red;"></span><br>
    이름: <input name="name"><br>
    닉네임: <input name="nickname"><br>
    성별:
    <label><input type="radio" name="gender" value="F"> 여성</label>
    <label><input type="radio" name="gender" value="M"> 남성</label><br>
    연령대: <select name="age">
        <option value="0-9">0-9세</option>
        <option value="10-19">10-19세</option>
        <option value="20-29">20-29세</option>
        <option value="30-39">30-39세</option>
        <option value="40-49">40-49세</option>
        <option value="50-59">50-59세</option>
        <option value="60+">60세 이상</option>
    </select><br>
    생일:
    <select name="birthday">
      <% for (int i = 1; i <= 12; i++) { %>
        <option value="<%= String.format("%02d", i) %>"><%= i %></option>
      <% } %>
    </select> 월
    <select name="birthday">
      <% for (int i = 1; i <= 31; i++) { %>
        <option value="<%= String.format("%02d", i) %>"><%= i %></option>
      <% } %>
    </select> 일<br>
    <button type="submit">회원가입</button>
  </form>
</body>
</html>