package com.multi.dorae.ticket;


public class PayVO {

	private String imp_uid; //결제고유번호
	private String merchant_uid; //주문번호
	private String apply_num; //결제카드번호
	private String paid_amount; //결제금액
	private String buyer_name; //주문자 이름
	private String buyer_tel; //주문자 전화번호
	private String email; //주문자 이메일
	private String play_id; //공연ID
	private String booking; //예매일
	private String seat_id; //티켓번호
	
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getApply_num() {
		return apply_num;
	}
	public void setApply_num(String apply_num) {
		this.apply_num = apply_num;
	}
	public String getPaid_amount() {
		return paid_amount;
	}
	public void setPaid_amount(String paid_amount) {
		this.paid_amount = paid_amount;
	}
	
	public String getBuyer_name() {
		return buyer_name;
	}
	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}
	public String getBuyer_tel() {
		return buyer_tel;
	}
	public void setBuyer_tel(String buyer_tel) {
		this.buyer_tel = buyer_tel;
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
	@Override
	public String toString() {
		return "PayVO [imp_uid=" + imp_uid + ", merchant_uid=" + merchant_uid + ", apply_num=" + apply_num
				+ ", paid_amount=" + paid_amount + ", buyer_name=" + buyer_name
				+ ", buyer_tel=" + buyer_tel + ", email=" + email + ", play_id=" + play_id + ", booking="
				+ booking + ", seat_id=" + seat_id + "]";
	}
	
	
	
	
	
	
}
