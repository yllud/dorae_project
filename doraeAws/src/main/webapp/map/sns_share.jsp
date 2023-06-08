<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
.link-icon { position: relative; display: inline-block; width: auto;    font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; }
.link-icon.twitter { background-image: url("https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-twitter.png"); background-repeat: no-repeat; }
.link-icon.facebook { background-image: url("https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-facebook.png"); background-repeat: no-repeat; } 
.link-icon.naver { background-image: url("https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-naver.png"); background-repeat: no-repeat; }
.link-icon.kakao { background-image: url("https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-kakao.png"); background-repeat: no-repeat; }
</style>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>

var thisUrl = "http://ec2-54-180-92-24.ap-northeast-2.compute.amazonaws.com:8080/dorae/search/playDetail?play_id="; //배포 url들어가야함
var snsTitle = "도래도래";

<%
	String playName = request.getParameter("playName"); // 공연 이름 값 가져오기
	String stageName = request.getParameter("stageName"); // 공연장 이름 값 가져오기
	String playId = request.getParameter("playId"); // 공연 id 값 가져오기

%>

var DetailUrl = thisUrl + "<%= playId %>";

function shareTwitter() {
    var sendText = snsTitle + " <" + "<%= playName %>" + ">"; // 전달할 텍스트
    var sendUrl = DetailUrl;
    var encodedText = encodeURIComponent(sendText); // 텍스트 인코딩
    var encodedUrl = encodeURIComponent(sendUrl); // URL 인코딩
    window.open("https://twitter.com/intent/tweet?text=" + encodedText + "&url=" + encodedUrl);
    window.close();
}

function shareNaver() {
    var url = encodeURIComponent(DetailUrl);
    var title = encodeURIComponent("도래도래 <" +  "<%=playName%>" + ">");
    var shareURL = "https://share.naver.com/web/shareView?url=" + url + "&title=" + title;
    window.open(shareURL);
    window.close();
}

//localhost주소라 아직 오류남
function shareFacebook() {
    var sendUrl = DetailUrl;
    var encodedUrl = encodeURIComponent(sendUrl); // URL 인코딩
    window.open("http://www.facebook.com/sharer/sharer.php?u=" + encodedUrl);
    window.close();
}

function shareKakao() {
    Kakao.init('7377e77dbf4c68a33c18016f4dc8dc45');
    Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
            title: '도래도래 <' + '<%=playName%>' + '>',
            description: '공연 상세보기',
            imageUrl: "https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/temp-banner3.png",
            link: {
                mobileWebUrl: DetailUrl,
                webUrl: DetailUrl
            }
        }
    });
    window.close();
}
	
</script>
<meta charset="UTF-8">
<title>sns 공유하기</title>
</head>
<body>
<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();">트위터</a>
<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();">페이스북</a>
<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();">카카오</a>
</body>
</html>