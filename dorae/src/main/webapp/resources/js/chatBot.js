// 웹소켓 변수 
let websocket;

// 소켓 연결
function connect() {
	console.log("연결 시도");
	// 연결할 웹소켓 주소
	var wsUri = "ws://localhost:8888/dorae/chat";
	// 소켓 객체 생성
	websocket = new WebSocket(wsUri);
	// 웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
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
						class: "chatBtn suggestBtn",
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

$("#chatOpenBtn").click(function() {
	connect(); // 챗봇을 처음 클릭할 때 소켓 연결
	$(this).off("click"); // 챗봇 열기 버튼 자신의 클릭 이벤트 제거
});