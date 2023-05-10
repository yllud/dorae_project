package com.multi.dorae.help;

public class FaqVO {
	
	private int faq_id;
	private String helpCategory;
	private String title;
	private String content;
	
	int getFaq_id() {
		return faq_id;
	}
	void setFaq_id(int faq_id) {
		this.faq_id = faq_id;
	}
	String getHelpCategory() {
		return helpCategory;
	}
	void setHelpCategory(String helpCategory) {
		this.helpCategory = helpCategory;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "FaqVO [faq_id=" + faq_id + ", helpCategory=" + helpCategory + ", title=" + title + ", content="
				+ content + "]";
	}
	
	
	
}
