<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>
	카카오 로그인 성공 ${nickname}
</h1>
<c:if test="${result != 0 }">
<P> ${vo.nickname}!!! welcome </P>
<a href="http://localhost:8888/dorae/mypage/mypage.jsp">
	<button style="background: pink;" >처음화면으로</button>
	</a>
</c:if>
<%
int r = (int)request.getAttribute("result");
if(r == 0){
	out.println("<script type='text/javascript'>alert('중복된 이메일인 경우(로그인 성공시 사용)');location.href = 'http://localhost:8888/dorae/mypage/mypage.jsp'</script>");
}
%>
<a href="http://localhost:8888/dorae/mypage/mypage.jsp">첫페이지로</a>
</body>
</html>