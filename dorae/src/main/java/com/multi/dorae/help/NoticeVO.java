package com.multi.dorae.help;

import java.util.Date;

public class NoticeVO {
	
	private int notice_id;
	private String admin_id;
	private String title;
	private String content;
	private Date created_at;
	private String tag;
	
	int getNotice_id() {
		return notice_id;
	}
	void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}
	String getAdmin_id() {
		return admin_id;
	}
	void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
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
	String getTag() {
		return tag;
	}
	void setTag(String tag) {
		this.tag = tag;
	}
	@Override
	public String toString() {
		return "NoticeVO [notice_id=" + notice_id + ", admin_id=" + admin_id + ", title=" + title + ", content="
				+ content + ", created_at=" + created_at + ", tag=" + tag + "]";
	}
	
	
	
}
