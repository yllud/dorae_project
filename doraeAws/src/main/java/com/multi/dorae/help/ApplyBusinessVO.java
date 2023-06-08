package com.multi.dorae.help;

import java.util.Date;

public class ApplyBusinessVO {
	
	private long apply_id;
	private String member_id;
	private Date created_at;
	private boolean approval; // 승인/거부 여부
	private Date approval_at; // 승인/거부 날짜
	
	public long getApply_id() {
		return apply_id;
	}
	public void setApply_id(long apply_id) {
		this.apply_id = apply_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public boolean isApproval() {
		return approval;
	}
	public void setApproval(boolean approval) {
		this.approval = approval;
	}
	public Date getApproval_at() {
		return approval_at;
	}
	public void setApproval_at(Date approval_at) {
		this.approval_at = approval_at;
	}
	
	@Override
	public String toString() {
		return "ApplyBusinessVO [apply_id=" + apply_id + ", member_id=" + member_id + ", created_at=" + created_at
				+ ", approval=" + approval + ", approval_at=" + approval_at + "]";
	}
}
