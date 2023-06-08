package com.multi.dorae.search;

public class CriteriaB {
	
	private int start;
	private int end;
	private int page;
	private String email;
	
	int amount = 10; // 한 페이지당 사업자의 공연 수

	//페이지 번호로 rownum 시작번호와 끝번호 설정
	public void setStartEnd(int page) {
		start = 1 + (page - 1) * amount;
		end = page * amount;
	}

	//리스트 수에 맞는 페이지 버튼 수 설정
	public int makePageBtn(int count) {
		return (int) Math.ceil((double) count / amount);
	}
	
	
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "CriteriaB [start=" + start + ", end=" + end + ", page=" + page + ", email=" + email + "]";
	}
	


}
