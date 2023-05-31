<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
#recommendList {
  max-width: 100%;
  overflow-x: auto;
}

.item_tb {
  margin: 20px;
  display: inline-block;
  width: 200px;
  height: 200px;
  text-align: center;
}

.item_tb img {
  width: 200px;
  object-fit: contain;
}
.item_tb div{
	width:200px;
}
#table_title {
  margin: 25px;
  font-size: 20pt;
}

ul {
  margin: 0;
  padding: 10px;
  list-style-type: none;
  white-space: nowrap;
}

li {
  display: inline-block;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class="recommendList">
    <ul>
      <c:forEach items="${list}" var="play">
        <li class="item_tb">
          <img src="${play.poster}" alt="${play.play_name}">
          <div><a href="/dorae/search/playDetail?play_id=${play.play_id}">${play.play_name}</a>></div>
          <div style="font-size: 15px;">${play.stage_name}</div>
          <div style="font-size: 15px;">${play.genre_name}</div>
        </li>
      </c:forEach>
    </ul>
  </div>
</body>
</html>