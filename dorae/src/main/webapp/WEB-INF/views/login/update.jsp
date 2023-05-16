<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${result != 0 }">
<P> ${vo.nickname}!!! welcome </P>
<a href="http://localhost:8888/dorae/mypage/mypage.jsp">
	<button style="background: pink;" >처음화면으로</button>
	</a>
</c:if>
<%
int r = (int)request.getAttribute("result");
if(r == 0){
	out.println("<script type='text/javascript'>alert('네이버로 로그인 완료');location.href = 'http://localhost:8888/dorae/mypage/mypage.jsp'</script>");
}
%>
</body>
</html>