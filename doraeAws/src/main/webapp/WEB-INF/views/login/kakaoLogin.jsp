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
<a href="../map/main.jsp">
	<button style="background: pink;" >처음화면으로</button>
	</a>
</c:if>
<%
int r = (int)request.getAttribute("result");
if(r == 0){
	out.println("<script type='text/javascript'>alert('로그인 성공');location.href = 'http://localhost:8888/dorae/map/main.jsp'</script>");
}
%>
</body>
</html>