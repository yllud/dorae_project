<!-- sidemenu.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
#result {
  overflow-y: auto; /* 수직 스크롤 적용 */
  max-height: 750px; /* 스크롤이 나타날 최대 높이 */
  padding-top: 11px;
}
</style>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"
	src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
  $(function() {
  $.ajax({
      url: 'test2.jsp', // 컨트롤러의 URL
      success: function(x) {
    	  $('#result').html(x);
          // 목록이 추가된 후에 자동 스크롤을 적용하기 위해 setTimeout 사용
          setTimeout(function() {
          var container = document.getElementById('result');
          container.scrollTop = container.scrollHeight;
        }, 0);
      },
      error: function(xhr, status, error) {
        console.log("ajax 실패!!!")
      }
     });
    
    
  });
</script>
</head>
<link rel="stylesheet" href="../resources/css/sidemenu.css" />
<body>
    <div class="left-side-bar">
        <div class="status-ico">
            <span>▶</span>
            <span>▼</span>
        </div>
    	<input id="address_input" type="text" placeholder="도로명주소를 검색해주세요">
        <div id="result">검색결과 없음</div>
    </div>
</body>
</html>