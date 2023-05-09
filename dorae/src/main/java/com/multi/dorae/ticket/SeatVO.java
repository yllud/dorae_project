package com.multi.dorae.ticket;

public class SeatVO {

	private String seat_member; //회원ID
	private String play_id; //공연ID
	private String seat_date; //공연날짜
	private String seat_time; //공연시간
	private String seat_number; //좌석번호
	private int seat_id; //티켓번호
	
	public String getSeat_member() {
		return seat_member;
	}
	public void setSeat_member(String seat_member) {
		this.seat_member = seat_member;
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
	public int getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(int seat_id) {
		this.seat_id = seat_id;
	}
	@Override
	public String toString() {
		return "SeatVO [seat_member=" + seat_member + ", play_id=" + play_id + ", seat_date=" + seat_date
				+ ", seat_time=" + seat_time + ", seat_number=" + seat_number + ", seat_id=" + seat_id + "]";
	}
	
	
	
}
