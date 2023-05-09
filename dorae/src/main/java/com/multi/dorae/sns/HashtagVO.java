package com.multi.dorae.sns;

public class HashtagVO {
	private int no;
	private String keyword;
	private int count;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "HashtagVO [no=" + no + ", keyword=" + keyword + ", count=" + count + "]";
	}

}
