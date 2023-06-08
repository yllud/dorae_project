package com.multi.dorae.mypage;

import java.util.List;

public class ReviewListVO {
	private int review_id;
	private String email;
	private String review_title;
	private List<String> review_images;
	private String review_content;
	private String review_tag;
	
	public int getReview_id() {
		return review_id;
	}
	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public List<String> getReview_images() {
		return review_images;
	}
	public void setReview_images(List<String> review_images) {
		this.review_images = review_images;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_tag() {
		return review_tag;
	}
	public void setReview_tag(String review_tag) {
		this.review_tag = review_tag;
	}
	
	@Override
	public String toString() {
		return "ReviewListVO [review_id=" + review_id + ", email=" + email + ", review_title=" + review_title
				+ ", review_images=" + review_images + ", review_content=" + review_content + ", review_tag="
				+ review_tag + "]";
	}
	
	
}
