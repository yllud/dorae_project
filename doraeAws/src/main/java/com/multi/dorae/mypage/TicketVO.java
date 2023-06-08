package com.multi.dorae.mypage;

public class TicketVO {
	private String email;
	private String play_id;
	private String seat_id;
	private String seat_date;
	private String seat_time;
	private String paid_amount;
	private String booking;
	private String play_name;
	private String stage_name;
	private String poster;
	
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
	public String getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(String seat_id) {
		this.seat_id = seat_id;
	}
	public String getSeat_date() {
		return seat_date;
	}
	public void setSeat_date(String seat_date) {
		this.seat_date = seat_date;
	}
	public String getSeat_time() {
		return seat_time;
	}
	public void setSeat_time(String seat_time) {
		this.seat_time = seat_time;
	}
	public String getPaid_amount() {
		return paid_amount;
	}
	public void setPaid_amount(String paid_amount) {
		this.paid_amount = paid_amount;
	}
	public String getBooking() {
		return booking;
	}
	public void setBooking(String booking) {
		this.booking = booking;
	}
	public String getPlay_name() {
		return play_name;
	}
	public void setPlay_name(String play_name) {
		this.play_name = play_name;
	}
	public String getStage_name() {
		return stage_name;
	}
	public void setStage_name(String stage_name) {
		this.stage_name = stage_name;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	
	@Override
	public String toString() {
		return "ticketListVO [email=" + email + ", play_id=" + play_id + ", seat_id=" + seat_id + ", seat_date="
				+ seat_date + ", seat_time=" + seat_time + ", paid_amount=" + paid_amount + ", booking=" + booking
				+ ", play_name=" + play_name + ", stage_name=" + stage_name + ", poster=" + poster + "]";
	}
	
}
