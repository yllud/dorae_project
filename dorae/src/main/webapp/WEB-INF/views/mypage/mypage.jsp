<%@page import="com.multi.dorae.login.NaverVO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<!-- mypage.css 추가 -->
<link rel="stylesheet" href="/dorae/resources/css/mypage.css">
<script type="text/javascript" src="/dorae/resources/js/jquery-3.6.4.js"></script>
<style>
#mypage{
	margin-top: 175px;
}
.button {
	margin-top: 20px;
}
    
      div.row {
        width: 100%;
        display: flex;
        border: 1px solid #003458;
      }
      div.left {
        margin-top:300px;
        width: 250px;
        /* float: left; */
        box-sizing: border-box;
      }
      div.right {
        width: 1400px;
         float: right;  
        margin-left:300px;
        box-sizing: border-box;
        background: #fcfcfa;
      }
.imageContainer {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 10px;
}

.imageContainer img {
	max-width: 100%;
	max-height: 400px;
	object-fit: contain;
	margin: 0 5px;
}
    
</style>

<!-- 헤더 추가 -->
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
	});
</script>

<script>
$(document).ready(function() {
    var $contentContainer = $("#contentContainer");

    $(document).on("click", ".btn-ajax", function() {
      var $button = $(this);
      var url = $button.data("url");
      var target = $button.data("target");

      $contentContainer.children().not(target).empty();
      $('#bookInfo').empty();

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
      });//ajax
    });//on
    
    
    $('.btn-ajax2').click(function() {
        var url = "/dorae/book/bookList";
        $.ajax({
          url: url,
          type: 'GET',
          data: { email: '<%=session.getAttribute("email")%>' },
          success: function(data) {
            //alert('북마크 클릭됨!');
            //console.log(data);
            $('#bookInfo').html(data);
          },
          error: function() {
            alert('데이터를 불러오는 중에 오류가 발생했습니다.');
          }
        });
      });
    
  });//ready
</script>

<!-- 프로필 이미지 수정 팝업 -->
<script>
function openPopup(url) {
    window.open(url, '_blank', 'width=800, height=600, top=100, left=100, resizable=yes');
}
</script>
</head>
<body>
<!-- 헤더 추가 -->
<header id="header" class="fixed-top"></header>
<div id="mypage">
<%
	if(session.getAttribute("email") != null){
%>

	<div class="left">
	<!-- 프로필 이미지 -->
	<c:choose>
  <c:when test="${not empty vo2.upload_image}">
    <div class="imageContainer">
      <img src="/dorae/resources/upload/${vo2.upload_image}" width="180" height="180" alt="프로필 이미지" />
    </div>
  </c:when>
  <c:otherwise>
    <c:choose>
      <c:when test="${not empty vo2.profile_image}">
        <div class="imageContainer">
          <img src="${vo2.profile_image}" width="180" height="180" alt="프로필 이미지" />
        </div>
      </c:when>
      <c:otherwise>
        <div class="no-image">이미지가 없습니다.</div>
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>
	<br>
	

<a href="javascript:void(0);" onclick="openPopup('/doare/mypage/profileUpdate.jsp?email=${sessionScope.email}')">프로필 수정</a>


<br>
	<!-- <table border="1" width="150" heigth="30"> -->
	<table heigth="50">
		<tr align="center">
			<td width="70">닉네임</td>
			<td width="150">${nickname}</td>
		</tr>
		<tr align="center">
			<td>가입일</td>
			<td><fmt:formatDate value="${vo2.joinDate}" pattern="yyyy년 MM월 dd일"/></td>
		</tr>
		<tr align="center">
			<td>방문 수</td>
			<td>1</td>
		</tr>
	</table>
	 <br>
	 <ul>
	 <li>
    <a href="javascript:void(0);" class="btn-ajax" data-url="../mypage/ticketList.jsp" data-target="#ticketInfo">예매내역</a>
    </li>

	<li>
    <a href="javascript:void(0);" class="btn-ajax2" data-url="/dorae/book/bookList" data-target="#bookInfo">북마크</a>
	</li>

  <li>
  <a href="javascript:void(0);" class="btn-ajax" data-url="../mypage/replyList.jsp" data-target="#replyList">작성한 후기</a>
  </li>
  <li>
  <a href="javascript:void(0);" class="btn-ajax" data-url="../mypage/reviewList.jsp" data-target="#reviewList">다녀온 후기</a>
  </li>
  <li>
  <a href="javascript:void(0);" class="btn-ajax" data-url="../help/contactList" data-target="#qnaList">문의내역</a>
  </li>
  </ul>
    
  </div>
  <div class="right" id="contentContainer">
    <!-- 예매내역을 표시할 영역 -->
    <div id="ticketInfo"></div>
    <!-- 북마크를 표시할 영역 -->
    <div id="bookInfo"></div>
    <!-- 후기내역을 표시할 영역 -->
    <div id="replyList"></div>
    <!-- 작성글을 표시할 영역 -->
    <div id="reviewList"></div>
    <!-- 문의내역을 표시할 영역 -->
    <div id="qnaList"></div>
    
  </div>
<%}else{out.println("<script type='text/javascript'>alert('로그인 실패');location.href = 'http://localhost:8888/dorae/login/login.jsp'</script>");} %>
</div>
</body>
</html>