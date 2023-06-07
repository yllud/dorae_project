<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- login.css 추가 -->
<link rel="stylesheet" href="/dorae/resources/css/memberCreate.css">
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
		  console.log(email);
		  var emailStatus = $('#emailStatus');

		  $.ajax({
		    url: '/dorae/login/checkEmail2',
		    type: 'post',
		    data: { email: email },
		    success: function (response) {
		    	console.log("-----" + response);
		      if (response == '1') {
		        // 중복된 이메일인 경우 처리
		        emailStatus.text('중복된 이메일입니다.');
		        emailStatus.css('color', 'red');
		      } else {
		        // 중복되지 않은 이메일인 경우 처리
		        emailStatus.text('사용 가능한 이메일입니다.');
		        emailStatus.css('color', 'green');
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
 <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
<h3>회원가입</h3>
<hr color="#ff9900">
<br>
<form action="../login/memberInsert" method="post" onsubmit="return validateForm()">
    <label>이메일</label> <input type="email" id="email" name="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}" oninput="checkEmail()" required>
	<span id="emailStatus"></span><br>
							
    <label>비밀번호</label> <input type="password" id="password" name="password" minlength="6"><br>
	<label>비밀번호 확인</label> <input type="password" id="confirmPassword" name="confirmPassword" oninput="checkPasswordMatch()" minlength="6"><br>
	<span id="passwordMatchMessage" style="color: red;"></span><br><br>
    
    <label>이름</label> <input name="name"><br>
    
    <!-- 닉네임에는 css 적용이 안돼서 직접 적용 -->
    <label>닉네임</label> 
    <input name="nickname" id="nickname" style="display: block; margin-bottom: 0px; border: 1px solid #E5E9F5; background-color: #F6F7FA; padding: 12px; margin-top: 10px; border-radius: 5px; width: 225px;"><br>
    
    <label>성별&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <label><input type="radio" name="gender" value="F"> 여성</label>
    <label><input type="radio" name="gender" value="M"> 남성</label><br><br>
    
    <label>연령대&nbsp;&nbsp;</label> <select name="age">
        <option value="0-9">0-9세</option>
        <option value="10-19">10-19세</option>
        <option value="20-29">20-29세</option>
        <option value="30-39">30-39세</option>
        <option value="40-49">40-49세</option>
        <option value="50-59">50-59세</option>
        <option value="60+">60세 이상</option>
    </select><br><br>
    
    <label>생일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <select name="birthday">
      <% for (int i = 1; i <= 12; i++) { %>
        <option value="<%= String.format("%02d", i) %>"><%= i %></option>
      <% } %>
    </select> 월
    <select name="birthday">
      <% for (int i = 1; i <= 31; i++) { %>
        <option value="<%= String.format("%02d", i) %>"><%= i %></option>
      <% } %>
    </select> 일<br><br>
    
    <button type="submit">회원가입</button>
  </form>
  </div>
      </div>
  </div>
</body>
</html>