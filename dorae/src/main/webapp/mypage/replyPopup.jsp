<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 작성</title>
<style>
body {
	text-align: center;
	padding: 20px;
	background-color: #f1f1f1;
	font-family: Arial, sans-serif;
}

.close {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
}

.input-area {
	margin-bottom: 10px;
}

.button-area {
	margin-top: 20px;
}

textarea {
	width: 100%;
	height: 100px;
	resize: none;
}

.button-area button {
	margin-right: 5px;
}
</style>
</head>
<body>
	<span class="close" onclick="window.close()">&times;</span>
	<h2>후기 작성</h2>
	<form action="replyInsert" method="get">
	<div class="input-area">
		공연id : <span id="playId"></span> <input type="hidden" name="play_id" id="playIdInput" value="${play_id}"><br>
		공연명 : <span id="playName"></span> <input type="hidden" name="play_name" id="playNameInput" value="${play_name}"><br>
		관람일 : <span id="seatDate"></span> <input type="hidden" name="seat_date" id="seatDateInput" value="${seat_date}">
		<span id="seatTime"></span> <input type="hidden" name="seat_time" id="seatTimeInput" value="${seat_time}"><br>
		티켓번호 : <span id="seatId"></span> <input type="hidden" name="seat_id" id="seatIdInput" value=""><br>
		<textarea placeholder="내용 입력 (최대 300글자)" id="inputText" name="text"
			maxlength="300"></textarea>
			작성자 : ${nickname} <input type="hidden" name="nickname" value="${nickname}"><br>
			<input type="hidden" name="email" value="${email}"><br>
	</div>
	<div class="input-area">
        <!-- 평가 점수 입력 폼 -->
        <label for="score">평가 점수:</label>
        <input type="number" name="score" id="score" min="1" max="10" required>
    </div>

	<div class="button-area">
		<button onclick="confirmPopup()">확인</button>
		<button onclick="window.close()">닫기</button>
	</div>
	</form>

	<script>
		function confirmPopup() {
			var inputText = document.getElementById("inputText").value;
			 var score = parseInt(document.getElementById("score").value);
		        // 여기에서 입력된 내용과 점수를 처리하는 로직을 추가하세요.
		        console.log("입력된 내용: " + inputText);
		        console.log("선택된 점수: " + score);
		}
		function fillTicketInfo(playId, playName, seatDate, seatTime, seatId) {
			document.getElementById("playId").textContent = playId;
			document.getElementById("playIdInput").value = playId;
			document.getElementById("playName").textContent = playName;
			document.getElementById("playNameInput").value = playName;
			document.getElementById("seatDate").textContent = seatDate;
			document.getElementById("seatDateInput").value = seatDate;
			document.getElementById("seatTime").textContent = seatTime;
			document.getElementById("seatTimeInput").value = seatTime;
			document.getElementById("seatId").textContent = seatId;
			document.getElementById("seatIdInput").value = seatId;
		}
	</script>
</body>
</html>