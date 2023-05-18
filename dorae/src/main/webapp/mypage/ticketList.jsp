<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<style>
        .button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
	<h2>예매내역</h2>
	${vo.nickname} 님
	

<hr color="blue">

<button onclick="openPopup()">후기작성</button>
    
    <script>
        function openPopup() {
            var popupWindow = window.open("../mypage/reply.jsp", "popupWindow", "width=500,height=500");
        }
    </script>
	

</body>
</html>