<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	//웹소켓
	let websocket;

	//입장 버튼을 눌렀을 때 호출되는 함수
	function connect() {
		// 웹소켓 주소
		var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat";
		// 소켓 객체 생성
		websocket = new WebSocket(wsUri);
		//웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
		websocket.onmessage = onMessage;
	}

	// * 1 메시지 전송
	function sendMessage(element) {
		websocket.send(element.value);
	}

	// * 2 메세지 수신
	function onMessage(res) {
		let temp;
		
		JSON.parse(res.data).bubbles.forEach(bubble => {
			if (bubble.type === "text") { // 일반 문자
				temp = $("<li>", {class: "msgBox"});
				temp.append(
					$("<span>", {text: bubble.data.description})
				);
			} else { // template, 버튼으로 생성
				temp = $("<li>", {class: "msgBox"});
				temp.append(
					$("<span>", {text: bubble.data.cover.data.description})
				);
				$("#chatList").append(temp);
				
				temp = $("<li>", {class: "btnBox"});
				bubble.data.contentTable.forEach(content => {
					temp.append(
						$("<button>", {
							text: content[0].data.title,
							value: content[0].data.data.action.data.postbackFull,
							class: "suggestBtn",
							onclick: "sendMessage(this)"
						})
					);
				})
			}
			
			$("#chatList").append(temp);
			
			// https://tom-dlog.tistory.com/entry/JSjQuery-%EC%8A%A4%ED%81%AC%EB%A1%A4-%EA%B0%80%EC%9E%A5-%ED%95%98%EB%8B%A8%EC%9C%BC%EB%A1%9C-%EC%9D%B4%EB%8F%99%EC%8B%9C%ED%82%A4%EA%B8%B0
			$('#chatList').animate({scrollTop: $('#chatList')[0].scrollHeight}, 600);
		})
	}
	
	function chatToggle() {
		$("#chatMain").toggle();
		$("#chatOpenBtn").toggle();
	}
	
	connect();
</script>
<style>
.chatCommon {
	border-radius: 30px;
	box-shadow: rgba(0, 0, 0, 0.3) 0px 12px 60px;
	position: fixed;
	right: 30px;
	bottom: 30px;
	box-sizing: border-box;
}

#chatOpenBtn {
	background-color: rgba(255, 165, 0, 0.9);
	padding: 10px;
}

#chatOpenBtn span {
	font-size: 50px;
	color: white;
}

#chatMain {
	background-color: rgba(247, 247, 248, 0.9);
	width: 350px;
	height: 600px;
}

.msgBox {
	background-color: rgba(0, 0, 0, 0.05);
	padding: 12px;
	margin: 10px 0;
	border-radius: 20px;
}

.btnBox {
	text-align: center;
}

.suggestBtn {
	border-radius: 10px;
	padding: 10px;
	font-weight: bold;
	font-size: 18px;
	margin: 0 6px 6px 0;
}

.chatMenuBtn {
	border: 0;
	padding: 8px;
	border-radius: 10px;
	background-color: rgba(0, 0, 0, 0.05);
}

#chatTop {
	position: absolute;
	top: 20px;
	box-sizing: border-box;
	display: flex;
	padding: 0 20px;
	width: 100%;
	align-items: center;
}

#chatTitle {
	width: 100%
}

#chatTitle span {
	vertical-align: middle;
}

#chat {
	height: 100%;
	padding: 80px 20px;
	box-sizing: border-box;
}

#chatList {
	overflow: auto;
	padding: 0;
	margin: 0;
	height: 100%;
	-ms-overflow-style: none; /* 인터넷 익스플로러 */
  	scrollbar-width: none; /* 파이어폭스 */
}

/* ( 크롬, 사파리, 오페라, 엣지 ) 동작 */
#chatList::-webkit-scrollbar {
  display: none;
}


#chatBottom {
	position: absolute;
	right: 20px;
	bottom: 20px;
}

.chatBtn {
	cursor: pointer;
}

.symbol {
	font-size: 30px; 
}

</style>
</head>
<body>
	<div id="chatMain" class="chatCommon" hidden="hidden">
		<div id="chatTop">
			<div id="chatTitle">
				<span class="material-symbols-outlined symbol">confirmation_number</span>
				<span style="font-size: 24px;">도래 챗봇</span>
			</div>
			<button class="chatBtn chatMenuBtn" onclick="chatToggle()">
				<span class="material-symbols-outlined symbol">close</span>
			</button>
		</div>
		<div id="chat">
			<ul id="chatList"></ul>
		</div>
		<div id="chatBottom">
			<button id="home" class="chatMenuBtn" onclick="sendMessage(this)" value="홈">
				<span class="material-symbols-outlined symbol">home</span>
			</button>
		</div>
	</div>
	<button id="chatOpenBtn" class="chatBtn chatCommon" onclick="chatToggle()">
		<span class="material-symbols-outlined symbol">contact_support</span>
	</button>
</body>
</html>