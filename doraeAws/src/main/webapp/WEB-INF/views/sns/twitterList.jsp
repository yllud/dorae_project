<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="twitter-list">
  <c:forEach var="tweet" items="${list}">
    <div class="twitter-item">
      <a href="${tweet.originalLink}" target="_blank" class="twitter-link">
        <div class="twitter-name">${tweet.user}(@${tweet.screenName})</div>
        <div class="twitter-text">${tweet.text}</div>
        <c:if test="${not empty tweet.mediaUrls}">
          <div class="twitter-img">
              <img src="${tweet.mediaUrls[0]}" alt="Tweet Image" />
          </div>
        </c:if>
      </a>
    </div>
  </c:forEach>
</div>