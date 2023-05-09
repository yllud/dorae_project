package com.multi.dorae.help;

import java.util.Date;

public class ContactVO {
	
	private long contact_id;
	private String member_id;
	private String title;
	private String content;
	private Date created_at;
	private String admin_id;
	private String answer;
	
	long getContact_id() {
		return contact_id;
	}
	void setContact_id(long contact_id) {
		this.contact_id = contact_id;
	}
	String getMember_id() {
		return member_id;
	}
	void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	String getTitle() {
		return title;
	}
	void setTitle(String title) {
		this.title = title;
	}
	String getContent() {
		return content;
	}
	void setContent(String content) {
		this.content = content;
	}
	Date getCreated_at() {
		return created_at;
	}
	void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	String getAdmin_id() {
		return admin_id;
	}
	void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	String getAnswer() {
		return answer;
	}
	void setAnswer(String answer) {
		this.answer = answer;
	}
	@Override
	public String toString() {
		return "contactVO [contact_id=" + contact_id + ", member_id=" + member_id + ", title=" + title + ", content="
				+ content + ", created_at=" + created_at + ", admin_id=" + admin_id + ", answer=" + answer + "]";
	}
	
	
}
