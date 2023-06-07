<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>naverLogin</title>
</head>
<body>
<h1>
	Hello world!  
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
	out.println("<script type='text/javascript'>alert('로그인 성공');location.href = 'http://localhost:8888/dorae/map/main.jsp'</script>");
}
%>

</body>
</html>
