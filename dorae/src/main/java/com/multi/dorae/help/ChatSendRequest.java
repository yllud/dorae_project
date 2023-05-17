package com.multi.dorae.help;

import java.util.ArrayList;
import java.util.List;

// CLOVA Chatbot으로 이용자의 질문을 전달합니다.
// https://api.ncloud-docs.com/docs/ai-application-service-chatbot-chatbot#%EC%9A%94%EC%B2%AD-%EB%B0%94%EB%94%94
public class ChatSendRequest {
	
	private String version = "v2"; // 챗봇 버전
	private String userId; // 봇과 채팅하는 사용자의 고유 ID, 최대 256자를 넘지 않아야 함
	private long timestamp;
	private List<Text> bubbles = new ArrayList<Text>(); // 사용자가 입력한 질문의 유형과 데이터
	private String event;
	
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public long getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
	public List<Text> getBubbles() {
		return bubbles;
	}
	public void setBubbles(List<Text> bubbles) {
		this.bubbles = bubbles;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	@Override
	public String toString() {
		return "ChatSendRequest [version=" + version + ", userId=" + userId + ", timestamp=" + timestamp + ", bubbles="
				+ bubbles + ", event=" + event + "]";
	}
	
	public void addText(String description) {
		this.bubbles.add(new Text(description));
	}
}
