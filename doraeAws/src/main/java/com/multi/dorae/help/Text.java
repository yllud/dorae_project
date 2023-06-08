package com.multi.dorae.help;

// 사용자가 입력한 질문의 유형과 데이터
// TextComponent
public class Text {

	private String type = "text";
	private TextData data;
	
	public Text(String description) {
		this.data = new TextData(description);
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public TextData getData() {
		return data;
	}
	public void setData(TextData data) {
		this.data = data;
	}
	
	// https://api.ncloud-docs.com/docs/ai-application-service-chatbot-chatbot#Text
	public class TextData {
		private String description; // 사용자 질의
		
		public TextData(String description) {
			super();
			this.description = description;
		}
		
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
	}
	
}
