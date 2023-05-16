package com.multi.dorae.help;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// https://retrieverj.tistory.com/55
@Controller
public class ChatBotWebSocketHandler extends TextWebSocketHandler {

	// 웹소켓 연결 성공 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		System.out.println(session.getId() + "가 연결 성공!");
	}

	// 웹소켓 메시지 수신 및 송신 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
	}

	// 웹소켓 연결 종료 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
		System.out.println(session.getId() + "가 연결 닫음!");
	}

	
}
