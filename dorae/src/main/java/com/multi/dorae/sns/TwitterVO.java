package com.multi.dorae.sns;

public class TwitterVO {
	private String user;
	private String screenName;
	private String text;

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getScreenName() {
		return screenName;
	}

	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return "TwitterVO [user=" + user + ", screenName=" + screenName + ", text=" + text + "]";
	}

}
