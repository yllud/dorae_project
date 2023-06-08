<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
    $(function() {
        // 시작하자마자 보여줄 ajax
        $.ajax({
            url: "../mypage/ticketList?page=1",
            success: function(x) {
                $('#result').html(x);
            }
        });
        // 캘린더 보기 버튼 클릭 시 팝업 창 열기
        $('#calendar').click(function() {
            openPopup();
        });

        // 팝업 창 열기
        function openPopup() {
            var popupWindow = window.open("../mypage/calendarPopup.jsp", "popupWindow", "width=800,height=800");
        }
    }); 
</script>
</head>
<body>
	<h2>예매내역</h2>
	${nickname} 님
	<!-- <button id="calendar">캘린더 보기</button> -->
	<div id="result">
	<!-- ajax의 $('#result').html(x)에서 result(결과)가 표시될 위치 -->
    </div>

</body>
</html>