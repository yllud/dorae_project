package com.multi.dorae.review;

import java.util.List;

public class ReviewVO {
	private int id;
	private String email;
	private String title;
	private List<String> images;
	private String content;
	private String tag;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<String> getImages() {
		return images;
	}

	public void setImages(List<String> images) {
		this.images = images;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	@Override
	public String toString() {
		return "ReviewVO [id=" + id + ", email=" + email + ", title=" + title + ", images=" + images + ", content="
				+ content + ", tag=" + tag + "]";
	}

	

}
