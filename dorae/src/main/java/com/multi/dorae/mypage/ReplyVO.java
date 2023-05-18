package com.multi.dorae.mypage;

import java.sql.Timestamp;

public class ReplyVO {
	private long r_number;
	private String text;
	private String booking;
	private String date;
	private String imp_uid;
	private String email;
	private Timestamp upload_date;
	
	public long getR_number() {
		return r_number;
	}
	public void setR_number(long r_number) {
		this.r_number = r_number;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getBooking() {
		return booking;
	}
	public void setBooking(String booking) {
		this.booking = booking;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getUpload_date() {
		return upload_date;
	}
	public void setUpload_date(Timestamp upload_date) {
		this.upload_date = upload_date;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [r_number=" + r_number + ", text=" + text + ", booking=" + booking + ", date=" + date
				+ ", imp_uid=" + imp_uid + ", email=" + email + ", upload_date=" + upload_date + "]";
	}
	
	
}
