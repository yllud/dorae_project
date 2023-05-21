package com.multi.dorae.help;

public class PageVO {

	// 현재페이지, 시작페이지, 끝페이지, 게시글 총 갯수, 페이지당 글 갯수, 마지막페이지, SQL쿼리에 쓸 start, end, 하단에 보여지는 페이지 갯수
	private int page, startPage, endPage, total, cntPerPage = 5, lastPage, start, end, cntPage = 5;

	public void calc() {
		calcLastPage();
		calcStartEndPage();
		calcStartEnd();
	}
	
	// 제일 마지막 페이지 계산
	public void calcLastPage() {
		setLastPage((int) Math.ceil((double) total / (double) cntPerPage)); // 예) 1.1 은 2페이지가 되어야하므로 올림 처리
	}

	// 시작, 끝 페이지 계산
	public void calcStartEndPage() {
		setEndPage(((page - 1) / cntPage + 1) * cntPage);
//		setEndPage(((int) Math.ceil((double) page / (double) cntPage)) * cntPage);
		if (getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
//		setStartPage(getEndPage() / cntPage * cntPage + 1);
		setStartPage((page - 1) / cntPage * cntPage + 1);
		if (getStartPage() < 1) {
			setStartPage(1);
		}
	}

	// DB 쿼리에서 사용할 start, end값 계산
	public void calcStartEnd() {
		setEnd(page * cntPerPage);
		setStart(getEnd() - cntPerPage + 1);
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCntPerPage() {
		return cntPerPage;
	}

	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
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

	public int getCntPage() {
		return cntPage;
	}

	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}

	@Override
	public String toString() {
		return "PageVO [page=" + page + ", startPage=" + startPage + ", endPage=" + endPage + ", total=" + total
				+ ", cntPerPage=" + cntPerPage + ", lastPage=" + lastPage + ", start=" + start + ", end=" + end
				+ ", cntPage=" + cntPage + "]";
	}

}
