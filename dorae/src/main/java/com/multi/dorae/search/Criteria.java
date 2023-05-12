package com.multi.dorae.search;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class Criteria {
	private int start;
	private int end; // 한 페이지 당 공연 수
	private int page;
	private String title;

	
	public void setStartEnd(int page) {
		int amount = 4;
		start = 1 + (page - 1) * amount;
		end = page * amount;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	@Override
	public String toString() {
		return "Criteria [start=" + start + ", end=" + end + ", page=" + page + ", title=" + title + "]";
	}

}
