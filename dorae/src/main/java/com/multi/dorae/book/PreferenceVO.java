package com.multi.dorae.book;

public class PreferenceVO {
	String email;
	String genre1;
	String genre2;
	String genre3;
	String area1;
	String area2;
	String area3;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGenre1() {
		return genre1;
	}
	public void setGenre1(String genre1) {
		this.genre1 = genre1;
	}
	public String getGenre2() {
		return genre2;
	}
	public void setGenre2(String genre2) {
		this.genre2 = genre2;
	}
	public String getGenre3() {
		return genre3;
	}
	public void setGenre3(String genre3) {
		this.genre3 = genre3;
	}
	public String getArea1() {
		return area1;
	}
	public void setArea1(String area1) {
		this.area1 = area1;
	}
	public String getArea2() {
		return area2;
	}
	public void setArea2(String area2) {
		this.area2 = area2;
	}
	public String getArea3() {
		return area3;
	}
	public void setArea3(String area3) {
		this.area3 = area3;
	}
	
	@Override
	public String toString() {
		return "PreferVO [email=" + email + ", genre1=" + genre1 + ", genre2=" + genre2 + ", genre3=" + genre3
				+ ", area1=" + area1 + ", area2=" + area2 + ", area3=" + area3 + "]";
	}
}
