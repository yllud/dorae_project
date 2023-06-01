package com.multi.dorae.ticket;

public class SeatVO {

	private String email; //회원e-mail
	private String play_id; //공연ID
	private String seat_date; //공연날짜
	private String seat_time; //공연시간
	private String seat_number; //좌석번호
	private String seat_id; //티켓번호
	private String cancel; //취소
	
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
	public String getSeat_number() {
		return seat_number;
	}
	public void setSeat_number(String seat_number) {
		this.seat_number = seat_number;
	}
	public String getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(String seat_id) {
		this.seat_id = seat_id;
	}
	public String getCancel() {
		return cancel;
	}
	public void setCancel(String cancel) {
		this.cancel = cancel;
	}
	@Override
	public String toString() {
		return "SeatVO [email=" + email + ", play_id=" + play_id + ", seat_date=" + seat_date + ", seat_time="
				+ seat_time + ", seat_number=" + seat_number + ", seat_id=" + seat_id + ", cancel=" + cancel + "]";
	}
	
	
	
}
