package com.multi.dorae.review;

public class ReviewPageVO {
	private int start;
	private int end;
	private int page;

	// 리뷰게시판 페이지 계산
	public void reviewStartEnd(int page) {
		// page별로 start, end값만 구해주면 됨.
		// 한 페이지에 4개씩 보여주기
		start = 1 + (page - 1) * 4;
		end = page * 4;
	}
	
	// 장소태그 페이지 계산
	public void tagStartEnd(int page) {
		start = 1 + (page - 1) * 10;
		end = page * 10;
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

}
