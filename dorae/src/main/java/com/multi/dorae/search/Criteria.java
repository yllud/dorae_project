package com.multi.dorae.search;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class Criteria {
	private int start;
	private int end;
	private int page;
	private String title;
	private String genre;
	private String state;

	int amount = 12; // 한 페이지당 공연 수

	//페이지 번호로 rownum 시작번호와 끝번호 설정
	public void setStartEnd(int page) {
		start = 1 + (page - 1) * amount;
		end = page * amount;
	}

	//리스트 수에 맞는 페이지 버튼 수 설정
	public int makePageBtn(int count) {
		return (int) Math.ceil((double) count / amount);
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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
		return "Criteria [start=" + start + ", end=" + end + ", page=" + page + ", title=" + title + ", genre=" + genre
				+ ", state=" + state + ", amount=" + amount + "]";
	}

}
