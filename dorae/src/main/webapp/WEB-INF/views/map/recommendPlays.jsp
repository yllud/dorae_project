<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
body {
  overflow-x: hidden;
}

.recommendList {
  max-width: 100%;
  overflow-x: auto;
  margin-top: 30px;
  margin-bottom: 30px;
  padding: 10px;
}

.recommend_ul {
  margin: 0;
  padding: 0;
  list-style-type: none;
  white-space: nowrap;
  overflow-x: auto;
}

li {
  display: inline-block;
  width: 200px;
  margin-right: 10px;
  text-align: center;
}

.item_tb {
  width: 100%;
  height: 100%;
}

.item_tb img {
  width: 200px;
  height: 270px;
  object-fit: cover;
  border-radius: 10px;
}

.item_tb div {
  margin-top: 10px;
  font-size: 14px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.item_tb a {
  color: #333;
  text-decoration: none;
}

.item_tb a:hover {
  text-decoration: underline;
}

h3 {
  margin: 0;
  font-weight: bold;
}

#p_setting {
  margin-top: 10px;
  font-size: 14px;
  color: #777;
}

li .name_size{
	font-size: 15pt;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class="recommendList">
    <ul class="recommend_ul">
      <h3>맞춤 추천 공연 <button><a href="/dorae/map/recommend.jsp">맞춤 재설정</a></button><div id="p_setting">지역 : ${bag.area1} ${bag.area2} ${bag.area3}<br>장르 : ${bag.genre1} ${bag.genre2} ${bag.genre3}</div></h3>
      <c:choose>
        <c:when test="${empty list}">
        	<p>
          		결과없음
        	</p>
        </c:when>
        <c:otherwise>
          <c:forEach items="${list}" var="play">
          	<a href="/dorae/search/playDetail?play_id=${play.play_id}">
            <li>
              <div class="item_tb">
                <img src="${play.poster}" alt="${play.play_name}">
                <div class="name_size"><b>${play.play_name}</b></div>
                <div>${play.stage_name}</div>
                <div>${play.genre_name}</div>
              </div>
            </li>
            </a>
          </c:forEach>
        </c:otherwise>
      </c:choose>
      
    </ul>
  </div>
</body>
</html>