package com.multi.dorae.search;

public class BusinessVO {

	int business_id;
	String email,play_id;
	int rownum;
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPlay_id() {
		return play_id;
	}
	public void setPlay_id(String play_id) {
		this.play_id = play_id;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	@Override
	public String toString() {
		return "BusinessVO [business_id=" + business_id + ", email=" + email + ", play_id=" + play_id + ", rownum="
				+ rownum + "]";
	}
	
	
}
