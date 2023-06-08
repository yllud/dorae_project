package com.multi.dorae.help;

import java.util.Date;

public class NoticeVO {
	
	private long notice_id;
	private String admin_id;
	private String title;
	private String content;
	private Date created_at;
	private String tag;
	
	public long getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(long notice_id) {
		this.notice_id = notice_id;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
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
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	@Override
	public String toString() {
		return "NoticeVO [notice_id=" + notice_id + ", admin_id=" + admin_id + ", title=" + title + ", content="
				+ content + ", created_at=" + created_at + ", tag=" + tag + "]";
	}

}
