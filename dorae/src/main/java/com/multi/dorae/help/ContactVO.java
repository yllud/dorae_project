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
	public long getContact_id() {
		return contact_id;
	}
	public void setContact_id(long contact_id) {
		this.contact_id = contact_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
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
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	@Override
	public String toString() {
		return "ContactVO [contact_id=" + contact_id + ", member_id=" + member_id + ", title=" + title + ", content="
				+ content + ", created_at=" + created_at + ", admin_id=" + admin_id + ", answer=" + answer + "]";
	}
	
	
	
}
