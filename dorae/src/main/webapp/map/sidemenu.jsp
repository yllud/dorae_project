<!-- sidemenu.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"
	src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
  $(function() {
    $.ajax({
      url: 'test2.jsp', // 컨트롤러의 URL
      success: function(x) {
    	  $('#result').html(x)
        // 성공적으로 응답을 받았을 때 처리할 로직
        // response 변수에는 컨트롤러에서 반환한 HTML 데이터가 포함됩니다.
        // 원하는 처리를 수행합니다.
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
    	<input id="address_input" type="text">
        <div id="result"></div>
    </div>
</body>
</html>