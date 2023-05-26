<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
.link-icon { position: relative; display: inline-block; width: auto;    font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; }
.link-icon.twitter { background-image: url(../resources/img/icon-twitter.png); background-repeat: no-repeat; }
.link-icon.facebook { background-image: url(../resources/img/icon-facebook.png); background-repeat: no-repeat; } 
.link-icon.naver { background-image: url(../resources/img/icon-naver.png); background-repeat: no-repeat; }
.link-icon.kakao { background-image: url(../resources/img/icon-kakao.png); background-repeat: no-repeat; }
</style>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>

var thisUrl = document.URL;

<%
	String playName = request.getParameter("playName"); // 공연 이름 값 가져오기
	String stageName = request.getParameter("stageName"); // 공연장 이름 값 가져오기
	/* String share_lat = request.getParameter("latitude"); // 공연장 위도 값 가져오기
	String share_lng = request.getParameter("longitude"); // 공연장 경도 값 가져오기 */
	//out.println("Received value: " + share_lat + ", " + share_lng); // 받은 값 출력

%>
	
function shareTwitter() {
    var sendText = "도래도래 공연 <" + "<%= playName %>" + ">"; // 전달할 텍스트
    <%-- var sendUrl = "https://map.naver.com/?x=" + <%= share_lat %> + "&y=" + <%= share_lng %>;// 전달할 네이버 지도 URL--%>
    var query = encodeURIComponent("<%= stageName %>"); // 검색할 공연장 이름 인코딩
    var sendUrl = "https://map.naver.com/v5/search?query=" + query; // 네이버 지도 검색 결과 페이지 URL
    var encodedText = encodeURIComponent(sendText); // 텍스트 인코딩
    var encodedUrl = encodeURIComponent(sendUrl); // URL 인코딩
    window.open("https://twitter.com/intent/tweet?text=" + encodedText + "&url=" + encodedUrl);
}
function shareFacebook() {
    var sendUrl = "https://www.naver.com/"; // 전달할 URL
    var encodedUrl = encodeURIComponent(sendUrl); // URL 인코딩
    window.open("http://www.facebook.com/sharer/sharer.php?u=" + encodedUrl);
}
function shareNaver() {
    var url = encodeURI(encodeURIComponent("https://www.naver.com/"));
    var title = encodeURI(playName);
    var shareURL = "https://share.naver.com/web/shareView?url=" + url + "&title=" + title;
    document.location = shareURL;
}
function shareKakao() {
	// 사용할 앱의 JavaScript 키 설정
  	Kakao.init('7377e77dbf4c68a33c18016f4dc8dc45');

  	// 카카오링크 버튼 생성
  	Kakao.Link.createDefaultButton({
	    container: '#btnKakao', // 카카오공유버튼ID
	    objectType: 'feed',
	    content: {
	    	title: "도래도래", // 보여질 제목
	      	description: "도래도래 사이트입니다", // 보여질 설명
	      	imageUrl: "https://www.naver.com/", // 콘텐츠 URL
	      	link: {
	      		mobileWebUrl: "https://www.naver.com/",
	         	webUrl: "https://www.naver.com/"
	      	}
	  	}
  	});
}
	
</script>
<meta charset="EUC-KR">
<title>sns 공유하기</title>
</head>
<body>
<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();">트위터</a>
<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();">페이스북</a>
<a id="btnNaver" class="link-icon naver" href="javascript:shareNaver();">네이버</a>
<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();">카카오</a>
</body>
</html>