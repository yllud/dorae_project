<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="tweet" items="${list}">
        <div style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">
            <h3><a href="${tweet.originalLink}" target="_blank">${tweet.user} (@${tweet.screenName})</a></h3>
            <p>${tweet.text}</p>
            
            <c:if test="${not empty tweet.mediaUrls}">
                <div>
                    <c:forEach var="mediaUrl" items="${tweet.mediaUrls}">
                        <img src="${mediaUrl}" style="max-width: 30%;">
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </c:forEach>

</body>
</html>