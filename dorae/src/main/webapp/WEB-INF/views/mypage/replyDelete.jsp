<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%
    out.println("<script type='text/javascript'>");
    out.println("alert('삭제 완료');");
    out.println("window.close();");
    out.println("window.history.back();");
    out.println("</script>");
    %>
</body>
</html>