package com.multi.dorae.mypage;


public class MypagePageVO {
	private int start;
	private int end;
	private int page;

	// 마이페이지 내역 페이지 계산
	public void mypageStartEnd(int page) {
		// page별로 start, end값만 구해주면 됨.
		// 한 페이지에 10개씩 보여주기
		start = 1 + (page - 1) * 10;
		// start페이지는 무조건 1부터 시작
		// 1page : 1 + 0 * 10 => start 1
		// 2page : 1 + 0 * 10 => start 11
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
