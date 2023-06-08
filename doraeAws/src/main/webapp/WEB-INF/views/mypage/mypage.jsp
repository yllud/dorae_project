<%@page import="com.multi.dorae.login.NaverVO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<!-- mypage.css 추가 -->
<link type="text/css" rel="stylesheet" media="all" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/mypage.css?<?=time()?>">
<!-- <link rel="stylesheet" href="/dorae/resources/css/mypage.css"> -->
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
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
    /* border: 1px solid #003458; */
}
div.left {
    margin-top:50px;
    width: 300px;
    /* float: left; */
    box-sizing: border-box;
}
div.right {
    width: 1400px;
    float: right;  
    margin-left:50px;
    margin-top:50px;
    box-sizing: border-box;
    /* background: #fcfcfa; */
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
        var url = "../book/bookList";
        $.ajax({
          url: url,
          type: 'GET',
          data: { email: '<%=session.getAttribute("email")%>' },
          success: function(data) {
            $contentContainer.children().not("#bookInfo").empty(); // 예매내역을 비움
            $('#bookInfo').html(data); // 북마크를 표시할 영역에 내용을 삽입
          },
          error: function() {
            alert('데이터를 불러오는 중에 오류가 발생했습니다.');
          }
        });
      });
   /*  $(document).on("click", ".btn-ajax3", function() {
        var url = $(this).data("url");
        var target = $(this).data("target");

        $contentContainer.children().not(target).empty(); // 이전 내용 지우기

        $.ajax({
            url: url,
            type: "GET",
            dataType: "html",
            success: function(data) {
                $(target).html(data); // 새로운 내용 업데이트
            },
            error: function() {
                alert("데이터를 불러오는 중에 오류가 발생했습니다.");
            }
        });
    }); */
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
<div id="mypage" class="row">
<%
	if(session.getAttribute("email") != null){
%>

	<div class="left">
	<!-- 프로필 이미지 -->
	<c:choose>
    <c:when test="${not empty vo2.upload_image}">
      <div class="imageContainer">
        <img src="../resources/upload/${vo2.upload_image}" width="180" height="180" alt="프로필 이미지" />
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
          <div class="imageContainer">
            <img src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/default_profile.png" width="180" height="180" alt="프로필 이미지" />
          </div>
        </c:otherwise>
      </c:choose>
    </c:otherwise>
  </c:choose>
	<br><br>
	<!-- <table border="1" width="150" heigth="30"> -->
	<table heigth="50">
		<tr align="center">
			<td width="80" style="font-size: 15px;">닉네임</td>
			<td width="220" style="font-size: 15px;"> ${nickname}</td>
		</tr>
		<tr align="center">
			<td style="font-size: 15px;">가입일</td>
			<td style="font-size: 15px;"><fmt:formatDate value="${vo2.joinDate}" pattern="yyyy년 MM월 dd일"/></td>
		</tr>
		<tr align="center">
			<td style="font-size: 15px;">방문수</td>
			<td style="font-size: 15px;">${vo2.visit_count}</td>
		</tr>
	</table>
	 <br>
	 <ul>
	 <li>
    <a style="font-size: 18px;" href="javascript:void(0);" class="btn-ajax" data-url="../mypage/ticketList.jsp" data-target="#ticketInfo">예매내역</a>
    </li>

	<li>
    <a style="font-size: 18px;" href="javascript:void(0);" class="btn-ajax2" data-url="../book/bookList" data-target="#bookInfo">북마크</a>
	</li>

  <li>
  <a style="font-size: 18px;" href="javascript:void(0);" class="btn-ajax" data-url="../mypage/replyList.jsp" data-target="#replyList">작성한 후기</a>
  </li>
  <li>
  <a style="font-size: 18px;" href="javascript:void(0);" class="btn-ajax" data-url="../mypage/reviewList.jsp" data-target="#reviewList">다녀온 후기</a>
  </li>
  <li>
  <a style="font-size: 18px;" href="javascript:void(0);" class="btn-ajax" data-url="../help/contactList" data-target="#qnaList">문의내역</a>
  </li>
  </ul>
    
  </div>
  
  
  <div class="right" id="contentContainer">
  
  <h2>&nbsp;회원정보</h2>
  <!-- <hr color="#ff9900"> -->
  <a style="font-size: 15px;" href="javascript:void(0);" onclick="openPopup('../mypage/profileUpdate.jsp?email=${sessionScope.email}')">
	&nbsp;&nbsp;프로필 이미지 수정 [클릭]</a><br><br><br>
  	<table class="user-info">
  	
  	<tr>
  	  <td style="font-size: 15px; width: 150px;"></td>
      <td style="font-weight: bold; font-size: 15px; width: 100px; height: 50px;">이름</td>
      <td>${vo2.name}</td>
    </tr>
  	
  	<tr>
  	  <td></td>
      <td style="font-weight: bold; font-size: 15px; width: 100px; height: 50px;">닉네임</td>
      <td>${vo2.nickname}</td>
    </tr>
    
    <tr>
      <td></td>
      <td style="font-weight: bold; font-size: 15px; width: 60px; height: 50px;">이메일</td>
      <td>${vo2.email}</td>
    </tr>
  	
  	<tr>
      <td></td>
      <td style="font-weight: bold; font-size: 15px; width: 60px; height: 50px;">연령대</td>
      <td>${vo2.age}</td>
    </tr>
  	
  	<tr>
  	  <td></td>
      <td style="font-weight: bold; font-size: 15px; width: 60px; height: 50px;">생일</td>
      <%-- vo2.birthday 값을 String에서 Date로 변환 --%>
		<%
		  NaverVO vo2 = (NaverVO) request.getAttribute("vo2");
		  String birthdayString = vo2.getBirthday();
		  SimpleDateFormat format = new SimpleDateFormat("MM-dd");
		  Date birthdayDate = format.parse(birthdayString);
		%>
		<td><fmt:formatDate value="<%= birthdayDate %>" pattern="MM월 dd일"/></td>
    </tr>
    
    <tr>
      <td></td>
      <td style="font-weight: bold; font-size: 15px; width: 60px; height: 50px;">가입일</td>
      <td><fmt:formatDate value="${vo2.joinDate}" pattern="yyyy년 MM월 dd일"/></td>
    </tr>
    
    <tr>
   	  <td></td>
      <td style="font-weight: bold; font-size: 15px; width: 60px; height: 50px;">방문수</td>
      <td>${vo2.visit_count}</td>
    </tr>
    
    <tr>
      <td></td>
	  <td style="font-weight: bold; font-size: 15px; width: 60px; height: 50px;">회원등급</td>
	  <td>
	    <c:choose>
	      <c:when test="${vo2.user_type eq 'user'}">
	        일반회원
	      </c:when>
	      <c:when test="${vo2.user_type eq 'business'}">
	        사업자
	      </c:when>
	      <c:otherwise>
	        기타
	      </c:otherwise>
	    </c:choose>
	  </td>
	</tr>
	<!-- <tr>
   	  <td></td>
      <td><button class="btn-ajax3" data-url="../mypage/memberUpdate.jsp" data-target="#memberInfo">회원수정</button></td>
      <td></td>
    </tr> -->
  </table>
  	
    <!-- 수정내역을 표시할 영역 -->
    <div id="memberInfo"></div>
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
<%}else{out.println("<script type='text/javascript'>alert('로그인 실패');location.href = '../login/login.jsp'</script>");} %>
</div>
</body>
</html>