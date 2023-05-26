<%@page import="com.multi.dorae.login.NaverVO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/style.css"/>
<meta charset="UTF-8">
<title>마이페이지</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
 <script>
    // JavaScript 코드
    window.addEventListener('DOMContentLoaded', function () {
        var menuItems = document.querySelectorAll('.menu-item');

        menuItems.forEach(function (menuItem) {
            var submenu = menuItem.querySelector('.submenu');

            menuItem.addEventListener('mouseover', function () {
                submenu.style.display = 'block';
            });

            menuItem.addEventListener('mouseout', function () {
                submenu.style.display = 'none';
            });
        });
    });
</script>
<style>
.button {
	margin-top: 20px;
}
    
      div.row {
        width: 100%;
        display: flex;
        border: 1px solid #003458;
      }
      div.left {
        width: 20%;
        float: left;
        box-sizing: border-box;
        background: #fff3f2;
      }
      div.right {
        width: 80%;
        float: right;
        box-sizing: border-box;
        background: #fcfcfa;
      }
    
</style>
<script>
$(document).ready(function() {
    var $contentContainer = $("#contentContainer");

    $(document).on("click", ".btn-ajax", function() {
      var $button = $(this);
      var url = $button.data("url");
      var target = $button.data("target");

      $contentContainer.children().not(target).empty();

      $.ajax({
        url: url,
        type: "GET",
        dataType: "html",
        success: function(data) {
          $(target).html(data);
        },
        error: function() {
          alert("데이터를 불러오는 중에 오류가 발생했습니다.");
        }
      });
    });
  });

</script>
</head>
<body>
<h1><a href="page01.jsp">도래도래</a></h1>
	<div class="menu">
		<nav class="clearfix">
			<ul class="clearfix">
				<!-- <li class="header_li"><a id="menu_search" href="">공연</a></li>
				<li class="header_li"><a id="menu_review" href="">리뷰검색</a></li>
				<li class="header_li"><a id="menu_help" href="">고객센터</a></li>
				<li class="header_li"><a id="menu_mypage" href="">	마이페이지</a></li> -->
								
				<li class="header_li"><a href="../search/search.jsp">공연</a></li>
				
				<div class="dropdown">
					<li class="header_li"><a href="../review/reviewBbs.jsp">커뮤니티</a></li>
						<div class="dropdown-content">
							<a href="../review/reviewBbs.jsp">다녀온 후기</a>
							<a href="../sns/sns.jsp">SNS추천</a>
							<a href="../noticeBbs/noticeBbs.jsp">공지사항</a>
						</div>
				</div>
					
				<li class="header_li"><a href="../help/main">고객센터</a></li> 
				<li class="header_li"><a  href="../mypage/main.jsp">마이페이지</a></li>
				
			</ul>
			<a id="pull" href="#"></a>
		</nav>
	</div>
<%
	if(session.getAttribute("email") != null){
%>

	<h2>도래도래</h2>
	${nickname} 님<br>
	
		<button>로그아웃</button>
	
	<a href="http://localhost:8888/dorae/login/login.jsp">
		<button>회원가입</button>
	</a>
	
	<div class="left">
	<img src="../resources/img/풍경.jpg" width=180 height=180>
	<br>
<form action="../mypage/uploadProfileImage.jsp" method="post" enctype="multipart/form-data">
  <input type="file" name="profileImage">
  <input type="submit" value="프로필 사진 업로드">
</form>
<br>
	<table border="1" width="150" heigth="30">
		<tr align="center">
			<td>닉네임</td>
			<td>${nickname}</td>
		</tr>
		<tr align="center">
			<td>가입일</td>
			<td><fmt:formatDate value="${vo2.joinDate}" pattern="yyyy년 MM월 dd일"/></td>
		</tr>
		<tr align="center">
			<td>관람수</td>
			<td>1</td>
		</tr>
	</table>
	 <br>
    <button class="btn-ajax" data-url="../mypage/ticketList.jsp" data-target="#ticketInfo">예매내역</button>
    <br>
    <button class="btn-ajax" data-url="../mypage/replyList.jsp" data-target="#replyList">작성한 후기</button>
    <br>
    <button class="btn-ajax" data-url="../mypage/reviewList.jsp" data-target="#reviewList">내 커뮤니티</button>
    <br>
    <button class="btn-ajax" data-url="../help/contactList" data-target="#qnaList">문의내역</button>
    <hr color="pink">
    <button>사업자 등록</button>
  </div>
  <div class="right" id="contentContainer">
    <!-- 예매내역을 표시할 영역 -->
    <div id="ticketInfo"></div>
    <!-- 후기내역을 표시할 영역 -->
    <div id="replyList"></div>
    <!-- 작성글을 표시할 영역 -->
    <div id="reviewList"></div>
    <!-- 문의내역을 표시할 영역 -->
    <div id="qnaList"></div>
  </div>
<%}else{out.println("<script type='text/javascript'>alert('로그인 실패');location.href = 'http://localhost:8888/dorae/login/login.jsp'</script>");} %>
</body>
</html>