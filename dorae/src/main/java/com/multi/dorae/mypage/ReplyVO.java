package com.multi.dorae.mypage;

import java.sql.Timestamp;

public class ReplyVO {
	private long r_number;
	private String text;
	private String play_id;
	private String booking;
	private String seat_date;
	private String seat_id;
	private String email;
	private Timestamp upload_date;
	private String nickname;
	
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
	public String getSeat_date() {
		return seat_date;
	}
	public void setSeat_date(String seat_date) {
		this.seat_date = seat_date;
	}
	public String getPlay_id() {
		return play_id;
	}
	public void setPlay_id(String play_id) {
		this.play_id = play_id;
	}
	public String getBooking() {
		return booking;
	}
	public void setBooking(String booking) {
		this.booking = booking;
	}
	public String getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(String seat_id) {
		this.seat_id = seat_id;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [r_number=" + r_number + ", text=" + text + ", play_id=" + play_id + ", booking=" + booking
				+ ", seat_date=" + seat_date + ", seat_id=" + seat_id + ", email=" + email + ", upload_date="
				+ upload_date + ", nickname=" + nickname + "]";
	}
}
