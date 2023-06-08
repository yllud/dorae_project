package com.multi.dorae.help;

public class FaqVO {
	
	private int faq_id;
	private String help_category_id;
	private String title;
	private String content;
	
	public int getFaq_id() {
		return faq_id;
	}
	public void setFaq_id(int faq_id) {
		this.faq_id = faq_id;
	}
	public String getHelp_category_id() {
		return help_category_id;
	}
	public void setHelp_category_id(String help_category_id) {
		this.help_category_id = help_category_id;
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
		return "FaqVO [faq_id=" + faq_id + ", help_category_id=" + help_category_id + ", title=" + title + ", content="
				+ content + "]";
	}
		
}
