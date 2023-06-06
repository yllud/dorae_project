<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
	overflow-x: hidden;
}

.recommendList {
/* 	min-width: 100%; */
	overflow-x: hidden;
	margin-top: 30px;
	margin-bottom: 30px;
	position: relative;
}

.recommend_header {
  position: sticky;
  top: 0;
  background-color: #fff;
  z-index: 1;
}

.recommend_scroll {
  position: relative;
  overflow-x: hidden;
  background-color: #f0f0f0;
  justify-content: flex-start; /* 왼쪽 정렬 */
  padding: 10px;
}

.recommend_ul {
	height: 367px;
	margin: 0;
	padding: 0;
	list-style-type: none;
	white-space: nowrap;
	overflow-x: hidden;
	scroll-behavior: smooth;
	scroll-snap-type: x mandatory;
	-webkit-overflow-scrolling: touch;
	transition: transform 0.3s ease-in-out;
}

.item_li {
	display: inline-block;
	width: 200px;
	margin-right: 10px;
	text-align: center;
	scroll-snap-align: start;
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

li .name_size {
	font-size: 15pt;
}

.button {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	width: 60px;
	height: 60px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 50%;
	text-align: center;
	line-height: 40px;
	font-size: 20px;
	cursor: pointer;
	transition: background-color 0.3s ease-in-out;
	opacity: 0.6;
}

.button:hover {
	background-color: #f0f0f0;
	opacity: 0.9;
}

#prevBtn {
	left: 10px;
}

#nextBtn {
	right: 10px;
}

#btn_reset{
padding: 10px;
background-color: #ff9900;
border: none;
border-radius: 10px;
font-family: 'NanumSquare', sans-serif;
font-size: 14px;
}

#btn_reset a{
color: white;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="recommendList">
		<div class="recommend_header">
			<h3>
				맞춤 추천 공연
				<div id="p_setting">
					지역 : ${bag.area1} ${bag.area2} ${bag.area3}<br>장르 :
					${bag.genre1} ${bag.genre2} ${bag.genre3}
				</div>
				<div style="text-align: center;">
					<button id="btn_reset" style="margin: 10px;">
						<a href="/dorae/map/recommend.jsp">맞춤 재설정</a>
					</button>
				</div>
			</h3>
		</div>
		<div class="recommend_scroll">
			<div id="prevBtn" class="button">
				<img src="/dorae/resources/img/arrow.png" alt="Previous"
					style="max-width: 100%; max-height: 100%;">
			</div>
			<div id="nextBtn" class="button">
				<img src="/dorae/resources/img/arrow.png" alt="Next"
					style="max-width: 100%; max-height: 100%; transform: scaleX(-1);">
			</div>
			<ul class="recommend_ul">
				<c:choose>
					<c:when test="${empty list}">
						<p>결과없음</p>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="play">
							<a href="/dorae/search/playDetail?play_id=${play.play_id}">
								<li class="item_li">
									<div class="item_tb">
										<img src="${play.poster}" alt="${play.play_name}">
										<div class="name_size">
											<b>${play.play_name}</b>
										</div>
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
	</div>
<script>
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');
  const recommendUl = document.querySelector('.recommend_ul');

  prevBtn.addEventListener('click', () => {
    if (recommendUl.scrollLeft === 0) {
      recommendUl.scrollTo({
        left: recommendUl.scrollWidth,
        behavior: 'smooth'
      });
    } else {
      recommendUl.scrollBy({
        left: -800,
        behavior: 'smooth'
      });
    }
  });

  nextBtn.addEventListener('click', () => {
    if (recommendUl.scrollLeft + recommendUl.clientWidth === recommendUl.scrollWidth) {
      recommendUl.scrollTo({
        left: 0,
        behavior: 'smooth'
      });
    } else {
      recommendUl.scrollBy({
        left: 800,
        behavior: 'smooth'
      });
    }
  });
</script>
</body>
</html>