package com.multi.dorae.book;

public class BookVO {
	int book_no;
	String email;
	String play_id;
	
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
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
	@Override
	public String toString() {
		return "BookVO [book_no=" + book_no + ", email=" + email + ", play_id=" + play_id + "]";
	}
}
